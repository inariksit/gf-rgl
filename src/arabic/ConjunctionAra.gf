concrete ConjunctionAra of Conjunction =
  CatAra ** open ResAra, Coordination, Prelude in {

lincat

  [S] =  {s1,s2 : Order => Str} ;
  [Adv] = {s1,s2 : Str} ;
  [NP] = {s1,s2 : Case => Str ; a : Agr ; empty : Str; isHeavy : Bool} ;
  [AP] = {s1,s2 : Species => Gender => Number => State => Case => Str} ;

lin


  BaseAdv = twoSS ;
  ConsAdv = consrSS comma ;
  ConjAdv = conjunctDistrSS ;

  BaseS = twoTable Order ;
  ConsS = consrTable Order comma ;
  ConjS = conjunctDistrTable Order ;

  BaseNP x y = emptyNP ** twoTable Case x y ** {
    a = conjAgr x.a y.a
    } ;
  ConsNP xs x = emptyNP ** consrTable Case comma xs x ** {
    a = conjAgr xs.a x.a
    } ;
  ConjNP conj ss = emptyNP ** conjunctDistrTable Case conj ss ** {
    a = let gn = pgn2gn (agr2pgn ss.a) in
        NounPer3 {g=gn.g ; n=conjNumber conj.n gn.n}
    } ;

  BaseAP = twoTable5 Species Gender Number State Case ;
  ConsAP = consrTable5 Species Gender Number State Case comma ;
  ConjAP = conjunctDistrTable5 Species Gender Number State Case ;


oper
  conjAgr : Agr -> Agr -> Agr = \a,b ->
  let gnA = pgn2gn (agr2pgn a) ; gnB = pgn2gn (agr2pgn b)
   in NounPer3 {g = conjGender gnA.g gnB.g ; n = conjNumber gnA.n gnB.n} ;

  conjGender : Gender -> Gender -> Gender = \g,h ->
    case g of {Fem => h ; _ => Masc} ;

  conjNumber : Number -> Number -> Number = \m,n ->
    case m of {Sg => n ; _ => Pl} ;

  -- move to predef?

  ListTable5 : PType -> PType -> PType -> PType -> PType -> Type = \P,Q,R,T,S ->
    {s1,s2 : P => Q => R => T => S => Str} ;

  twoTable5 : (P,Q,R,T,S : PType) -> (_,_ : {s : P => Q => R => T => S => Str}) ->
              ListTable5 P Q R T S =
    \_,_,_,_,_,x,y ->
    {s1 = x.s ; s2 = y.s} ;

  consrTable5 :
    (P,Q,R,T,S : PType) -> Str -> {s : P => Q => R => T => S => Str} ->
       ListTable5 P Q R T S -> ListTable5 P Q R T S =
     \P,Q,R,T,S,c,x,xs ->
    {s1 = \\p,q,r,t,s => xs.s1 ! p ! q ! r ! t ! s ++ c ++ xs.s2 ! p ! q ! r ! t ! s ;
     s2 = x.s
    } ;

  conjunctDistrTable5 :
    (P,Q,R,T,S : PType) -> ConjunctionDistr -> ListTable5 P Q R T S ->
       {s : P => Q => R => T => S => Str} =
    \P,Q,R,T,S,or,xs ->
    {s = \\p,q,r,t,s => or.s1++ xs.s1 ! p ! q ! r ! t ! s ++ or.s2 ++ xs.s2 ! p ! q ! r ! t ! s} ;
}
