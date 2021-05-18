--1 Spanish auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.
--

instance ResSpa of ResRomance - [insertObject] = DiffSpa ** open CommonRomance, Prelude in {
 ---  flags optimize=noexpand ;

 oper

--   Verb = {s : VF => Str ; vtyp : VType ; p : Str} ;

   insertObject : Compl -> NounPhrase -> VP -> VP = \c,np,vp ->
    let
      obj = np.s ! c.c ;
      verb : Verb = case vp.s.vtyp of {
            VDat => vp.s ** { -- me/te/le/… {gustas tu, gustan los pájaros} agreement comes from object!
             s = \\vf => getObjAgr np.a vp.s.s ! vf} ;
            _ => vp.s -- normal case, agreement comes from subject
        } ;
    in {
      s   = verb ; --vp.s ;
      agr = case <np.hasClit, c.isDir, c.c> of {
        <True,True,Acc> => vpAgrClits vp.s np.a ;
        _   => vp.agr -- must be dat
        } ;
      clit1 = vp.clit1 ++ obj.c1 ;
      clit2 = vp.clit2 ++ obj.c2 ;
      clit3 = addClit3 np.hasClit [] (imperClit np.a obj.c1 obj.c2) vp.clit3 ;
      isNeg = orB vp.isNeg np.isNeg ;
      comp  = \\a => c.s ++ obj.comp ++ vp.comp ! a ;
      neg   = vp.neg ;
      ext   = vp.ext ;
    } ;

   getObjAgr : Agr -> (VF => Str) -> (VF => Str) = \a,verb -> table {
     VFin tm n p =>
       datPron n p ++            -- me/te/le/… : stays open
       verb ! VFin tm a.n a.p ;  -- gustan     : is fixed to object agr
     -- TODO: to say "no puede gustarme todo", what do I need?
     -- VInfin b => glue
     --   (verb ! VInfin b)
     --   (datPron a.n a.p) ;       -- no puede gustarme todo
     VImper npi => "que" ++ datPronNPI ! npi ++   -- que me/te/…
       verb ! VFin (VPres Conjunct) a.n a.p ;   -- gusten todos
     x => verb ! x
     -- TODO: how to say in imperative? "que te gusten los …"
     -- VPart Gender Number
     -- VGer
     -- VPresPart  --- = VGer except in Italian
     } ;


   -- datPronVF : VF => Str = table {
   --   VFin _ n p => datPron n p ;
   --   VPart g n => "datPron.vpart>" ;
   --   VGer => "<datPron.vger>" ;
   --   VPresPart  => "<datPron.vprespart>" ;
   --   VInfin _ => "<datPron.vinfin>"
   --   } ;

   datPronNPI : NumPersI => Str = table {
     SgP2 => datPron Sg P2 ;
     PlP1 => datPron Pl P1 ;
     PlP2 => datPron Pl P2 };



   datPron : Number -> Person -> Str = \n,p -> case <n,p> of {
     <Sg,P1> => "me" ;
     <Sg,P2> => "te" ;
     <Sg,P3> => "le" ;
     <Pl,P1> => "nos" ;
     <Pl,P2> => "os" ;
     <Pl,P3> => "les"
     } ;

} ;
