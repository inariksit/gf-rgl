--1 Adverb: Adverbs and Adverbial Phrases

concrete AdverbYrl of Adverb = CatYrl ** open Prelude, ResYrl, (N=NounYrl) in {

  lin

-- The two main ways of forming adverbs are from adjectives and by
-- prepositions from noun phrases.

    -- PositAdvAdj : A -> Adv ;                 -- warmly
--    PositAdvAdj = id SS ;

    -- PrepNP      : Prep -> NP -> Adv ;        -- in the house
    -- Is applying a postposition the same process as possession by NP?
    -- NSG3's house 'X ruka', 3SG's house 'suka',  3SG's fish 'i pirá'
    -- near NSG3   'X ruaki', near 3SG    'suaki', with 3SG   'i irũmu'
    PrepNP prep np =
      let cn : CN = N.PossNP <prep : CN> np
       in {s = cn.s ! NAbs} ;

-- Comparative adverbs have a noun phrase or a sentence as object of
-- comparison.

    -- ComparAdvAdj  : CAdv -> A -> NP -> Adv ; -- more warmly than John
    -- ComparAdvAdjS : CAdv -> A -> S  -> Adv ; -- more warmly than he runs

-- Adverbs can be modified by 'adadjectives', just like adjectives.

    -- AdAdv  : AdA -> Adv -> Adv ;             -- very quickly
    AdAdv ada adv = cc2 adv ada ;

-- Like adverbs, adadjectives can be produced by adjectives.
{-
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
