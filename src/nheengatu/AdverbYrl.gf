--1 Adverb: Adverbs and Adverbial Phrases

concrete AdverbYrl of Adverb = CatYrl ** open Prelude in {

  lin

-- The two main ways of forming adverbs are from adjectives and by
-- prepositions from noun phrases.

    -- PositAdvAdj : A -> Adv ;                 -- warmly
--    PositAdvAdj = id SS ;
    -- PrepNP      : Prep -> NP -> Adv ;        -- in the house
    PrepNP prep np = {s = np.s ! prep.nc ++ prep.s} ;

-- Comparative adverbs have a noun phrase or a sentence as object of
-- comparison.
{-
    -- ComparAdvAdj  : CAdv -> A -> NP -> Adv ; -- more warmly than John
    ComparAdvAdj = cc3 ;
    -- ComparAdvAdjS : CAdv -> A -> S  -> Adv ; -- more warmly than he runs
    ComparAdvAdjS = cc3 ;

-- Adverbs can be modified by 'adadjectives', just like adjectives.

    -- AdAdv  : AdA -> Adv -> Adv ;             -- very quickly
    AdAdv = cc2 ;

-- Like adverbs, adadjectives can be produced by adjectives.

    -- PositAdAAdj : A -> AdA ;                 -- extremely
    PositAdAAdj = id SS ;

-- Subordinate clauses can function as adverbs.

    -- SubjS  : Subj -> S -> Adv ;              -- when she sleeps
    SubjS = cc2 ;
-- Comparison adverbs also work as numeral adverbs.

    -- AdnCAdv : CAdv -> AdN ;                  -- less (than five)
    AdnCAdv = id SS ;
-}
}
