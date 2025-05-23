concrete AdverbBen of Adverb = CatBen ** open ResBen, ParadigmsBen, Prelude in {

lin

  -- : A -> Adv ;
  -- PositAdvAdj adj =

  -- : CAdv -> A -> NP -> Adv ; -- more warmly than John
  -- ComparAdvAdj cadv a np =

  -- : CAdv -> A -> S  -> Adv ; -- more warmly than he runs
  -- ComparAdvAdjS cadv a s =

  -- : Prep -> NP -> Adv ; 
  PrepNP prep np = {
    s = np.s ! prep.c ++ prep.s
  } ;

-- Adverbs can be modified by 'adadjectives', just like adjectives.

  -- : AdA -> Adv -> Adv ;             -- very quickly
  AdAdv ada adv = {
    s = ada.s ++ adv.s 
  } ;

-- Like adverbs, adadjectives can be produced by adjectives.

  -- : A -> AdA ;                 -- extremely
  -- PositAdAAdj a =

  -- Subordinate clauses can function as adverbs.

  -- : Subj -> S -> Adv ;
  -- SubjS subj s = {s = subj.s ++ s.s} ;

-- Comparison adverbs also work as numeral adverbs.

  -- : CAdv -> AdN ;                  -- less (than five)
  -- AdnCAdv cadv =  ;



}
