concrete StructuralYrl of Structural = CatYrl **
  open Prelude, ResYrl in {

-------
-- Ad*
{-
lin almost_AdA = mkAdA "" ;
lin almost_AdN = ss "" ;
lin at_least_AdN = ss "" ;
lin at_most_AdN = ss "" ;
lin so_AdA = ss "" ;
lin too_AdA = ss "" ;
-}
lin very_AdA = ss "retana" ;
{-
lin as_CAdv = { s = "" ; p = [] } ;
lin less_CAdv = { s = "" ; p = [] } ;
lin more_CAdv = { s = "" ; p = [] } ;

lin how_IAdv = mkIAdv "" ;

lin how8much_IAdv = ss "" ;
lin when_IAdv = ss "" ;
lin where_IAdv = mkIAdv
lin why_IAdv = mkIAdv

lin always_AdV = ss "" ;

lin everywhere_Adv = ss "" ;
lin here7from_Adv = ss "" ;
lin here7to_Adv = ss "" ; -}
lin here_Adv = mkAdvLoc "iké" ;
--lin quite_Adv = ss "" ;
--lin somewhere_Adv = ss "" ;
--lin there7from_Adv = ss "" ;
--lin there7to_Adv = ss "" ;
lin there_Adv = mkAdvLoc "ape" ;
oper mkAdvLoc = ss ;
{-
-------
-- Conj

lin and_Conj =
lin or_Conj =
-- lin if_then_Conj = mkConj
-- lin both7and_DConj = mkConj "" "" pl ;
lin either7or_DConj =
--
-- lin but_PConj = ss "" ;
-- lin otherwise_PConj = ss "" ;
-- lin therefore_PConj = ss "" ;


-----------------
-- *Det and Quant

--lin how8many_IDet = R.indefDet "" pl ;

lin all_Predet =
--lin not_Predet = { s = "" } ;
--lin only_Predet = { s = "" } ;
lin most_Predet =

lin every_Det = R.defDet
lin few_Det = R.indefDet
lin many_Det = R.indefDet
lin much_Det = R.indefDet

lin somePl_Det =
lin someSg_Det =

lin no_Quant = mkPrep no_Quant
-}
lin that_Quant = mkQuant "nhaã" "nhaã-itá" NAbs ;
lin this_Quant = mkQuant "kuá" "kuá-itá" NAbs ;
{-
lin which_IQuant = defIQuant "" ;


-----
-- NP

lin everybody_NP = defNP "" N.NumPl ;
lin everything_NP = defNP "" N.NumSg ;
lin nobody_NP = ""
lin nothing_NP = defNP "" N.NumSg ;
lin somebody_NP = defNP "" N.NumSg ;
lin something_NP = defNP "" N.NumSg ;

oper
 defNP : Str -> Num -> NP = {} ;
-}

-------
-- Prep

-- lin above_Prep = mkPrep
-- lin after_Prep = mkPrep ""
-- lin before_Prep = mkPrep "" ;
-- lin behind_Prep = mkPrep ""  ;
-- lin between_Prep =
-- lin by8agent_Prep = mkPrep ;
-- lin by8means_Prep = mkPrep ;
-- lin during_Prep = mkPrep ;
-- lin except_Prep = mkPrep ;
-- lin for_Prep = mkPrep ;
-- lin from_Prep = mkPrep "" ;
-- lin in8front_Prep =  ;
lin in_Prep = mkPrep "kuara upé" ;
lin on_Prep = mkPrep "upé" ;
-- lin part_Prep = mkPrep ;
-- lin possess_Prep = mkPrep ;
-- lin through_Prep = mkPrep ;
-- lin to_Prep = mkPrep ;
lin under_Prep = mkPrep "ruaki" "suaki" ; -- Repurpose this as "near", just to test a NCS preposition
lin with_Prep = mkPrep "irũmu" ;
-- lin without_Prep = mkPrep ;


-------
-- Pron

-- Pronouns are closed class, no constructor in ParadigmsYrl.
-- it_Pron =
i_Pron = mkPronoun "ixé" "se" Sg P1 ;
youPol_Pron,
youSg_Pron = mkPronoun "indé" "ne" Sg P2 ;
he_Pron,
she_Pron = mkPronoun "aé" "i" Sg P3 ;
we_Pron = mkPronoun "iandé" "iané" Pl P1 ;
youPl_Pron = mkPronoun "penhẽ" "pe" Pl P2 ;
they_Pron = mkPronoun "aintá" "ta" Pl P3 ;

--lin whatPl_IP = ;
--lin whatSg_IP = mkIP
--lin whoPl_IP = ;
--lin whoSg_IP = mkIP

-------
-- Subj

-- lin although_Subj = mkSubj "" False ;
-- lin because_Subj  = mkSubj "" False ;
-- lin if_Subj = mkSubj "" True ;
--lin that_Subj = {s = ""} ;
-- lin when_Subj = mkSubj "" False ;


------
-- Utt

lin language_title_Utt = ss "nheengatu" ;
lin no_Utt = ss "niti" ;
lin yes_Utt = ss "" ;


-------
-- Verb
{-
lin have_V2 = mkV2 ;
lin can8know_VV =  -- can (capacity)
lin can_VV =  ;   -- can (possibility)
lin must_VV =
lin want_VV =


------
-- Voc

lin please_Voc = ss "" ;

 -}

}
