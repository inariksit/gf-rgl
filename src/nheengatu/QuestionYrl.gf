--1 Question: Questions and Interrogative Pronouns

concrete QuestionYrl of Question = CatYrl ** open Prelude, ResYrl in {

-- A question can be formed from a clause ('yes-no question') or
-- with an interrogative.
{-
  lin
    -- QuestCl     : Cl -> QCl ;            -- does John walk
    QuestCl = id SS ;
    -- QuestVP     : IP -> VP -> QCl ;      -- who walks
    QuestVP = cc2 ;
    -- QuestSlash  : IP -> ClSlash -> QCl ; -- whom does John love
    QuestSlash = cc2 ;
    -- QuestIAdv   : IAdv -> Cl -> QCl ;    -- why does John walk
    QuestIAdv = cc2 ;
    -- QuestIComp  : IComp -> NP -> QCl ;   -- where is John
    QuestIComp = cc2 ;

-- Interrogative pronouns can be formed with interrogative
-- determiners, with or without a noun.

    -- IdetCN    : IDet -> CN -> IP ;       -- which five songs
    IdetCN = cc2;
    -- IdetIP    : IDet       -> IP ;       -- which five
    IdetIP = id SS ;

-- They can be modified with adverbs.

    -- AdvIP     : IP -> Adv -> IP ;        -- who in Paris
    AdvIP = cc2 ;

-- Interrogative quantifiers have number forms and can take number modifiers.

    -- IdetQuant : IQuant -> Num -> IDet ;  -- which (five)
    IdetQuant = cc2 ;

-- Interrogative adverbs can be formed prepositionally.

    -- PrepIP    : Prep -> IP -> IAdv ;     -- with whom
    PrepIP = cc2 ;

-- They can be modified with other adverbs.

    -- AdvIAdv   : IAdv -> Adv -> IAdv ;    -- where in Paris
    AdvIAdv = cc2 ;

-- Interrogative complements to copulas can be both adverbs and
-- pronouns.

    -- CompIAdv  : IAdv -> IComp ;          -- where (is it)
    CompIAdv = id SS ;
    -- CompIP    : IP   -> IComp ;          -- who (is it)
    CompIP = id SS ;

-- More $IP$, $IDet$, and $IAdv$ are defined in $Structural$.

-- Wh questions with two or more question words require a new, special category.

  lincat
    QVP = SS ;          -- buy what where
  lin
    -- ComplSlashIP  : VPSlash -> IP -> QVP ;   -- buys what
    ComplSlashIP = cc2 ;
    -- AdvQVP        : VP  ->   IAdv -> QVP ;   -- lives where
    AdvQVP = cc2 ;
    -- AddAdvQVP     : QVP ->   IAdv -> QVP ;   -- buys what where
    AddAdvQVP = cc2 ;

    -- QuestQVP      : IP -> QVP -> QCl ;       -- who buys what where
    QuestQVP = cc2 ;

-}
}
