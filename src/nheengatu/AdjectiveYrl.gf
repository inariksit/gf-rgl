--1 Adjective: Adjectives and Adjectival Phrases

concrete AdjectiveYrl of Adjective = CatYrl ** open Prelude in {
  lin

-- The principal ways of forming an adjectival phrase are
-- positive, comparative, relational, reflexive-relational, and
-- elliptic-relational.

    -- PositA  : A  -> AP ;        -- warm
    PositA a = a ;
{-
    -- ComparA : A  -> NP -> AP ;  -- warmer than I
    ComparA = cc2 ;
    -- ComplA2 : A2 -> NP -> AP ;  -- married to her
    ComplA2 = cc2 ;
    -- ReflA2  : A2 -> AP ;        -- married to itself
    ReflA2 = id SS ;
    -- UseA2   : A2 -> AP ;        -- married
    UseA2 = id SS ;
    -- UseComparA : A  -> AP ;     -- warmer
    UseComparA = id SS ;
    -- CAdvAP  : CAdv -> AP -> NP -> AP ; -- as cool as John
    CAdvAP = cc3 ;

-- The superlative use is covered in $Ord$.

    -- AdjOrd  : Ord -> AP ;       -- warmest
    AdjOrd = id SS ;

-- Sentence and question complements defined for all adjectival
-- phrases, although the semantics is only clear for some adjectives.

    -- SentAP  : AP -> SC -> AP ;  -- good that she is here
    SentAP = cc2 ;

-- An adjectival phrase can be modified by an *adadjective*, such as "very".

    -- AdAP    : AdA -> AP -> AP ; -- very warm
    AdAP = cc2 ;

-- It can also be postmodified by an adverb, typically a prepositional phrase.

    -- AdvAP   : AP -> Adv -> AP ; -- warm by nature
    AdvAP = cc2 ;

-- The formation of adverbs from adjectives (e.g. "quickly") is covered
-- in [Adverb Adverb.html]; the same concerns adadjectives (e.g. "extremely").
-}
}
