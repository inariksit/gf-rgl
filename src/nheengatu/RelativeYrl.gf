--1 Relative clauses and pronouns

concrete RelativeYrl of Relative = CatYrl ** open Prelude in{
{-
  lin

-- The simplest way to form a relative clause is from a clause by
-- a pronoun similar to "such that".

    -- RelCl    : Cl -> RCl ;            -- such that John loves her
    RelCl = id SS ;

-- The more proper ways are from a verb phrase
-- (formed in [``Verb`` Verb.html]) or a sentence
-- with a missing noun phrase (formed in [``Sentence`` Sentence.html]).

    -- RelVP    : RP -> VP -> RCl ;      -- who loves John
    RelVP = cc2 ;
    -- RelSlash : RP -> ClSlash -> RCl ; -- whom John loves
    RelSlash = cc2 ;

-- Relative pronouns are formed from an 'identity element' by prefixing
-- or suffixing (depending on language) prepositional phrases or genitives.

    -- IdRP  : RP ;                      -- which
    IdRP = ss "" ;
    -- FunRP : Prep -> NP -> RP -> RP ;  -- the mother of whom
    FunRP = cc3 ;
-}
}
