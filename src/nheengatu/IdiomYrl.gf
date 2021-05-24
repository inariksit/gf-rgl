--1 Idiom: Idiomatic Expressions

concrete IdiomYrl of Idiom = CatYrl ** open Prelude in {

-- This module defines constructions that are formed in fixed ways,
-- often different even in closely related languages.
{-
  lin

    -- ImpersCl  : VP -> Cl ;        -- it is hot
    ImpersCl = id SS ;
    -- GenericCl : VP -> Cl ;        -- one sleeps
    GenericCl = id SS ;

    -- CleftNP   : NP  -> RS -> Cl ; -- it is I who did it
    CleftNP = cc2 ;
    -- CleftAdv  : Adv -> S  -> Cl ; -- it is here she slept
    CleftAdv = cc2 ;

    -- ExistNP   : NP -> Cl ;        -- there is a house
    ExistNP = id SS ;
    -- ExistIP   : IP -> QCl ;       -- which houses are there
    ExistIP = id SS ;

-- 7/12/2012 generalizations of these

    -- ExistNPAdv : NP -> Adv -> Cl ;    -- there is a house in Paris
    ExistNPAdv = cc2 ;
    -- ExistIPAdv : IP -> Adv -> QCl ;   -- which houses are there in Paris
    ExistIPAdv = cc2 ;

    -- ProgrVP   : VP -> VP ;        -- be sleeping
    ProgrVP = id SS ;

    -- ImpPl1    : VP -> Utt ;       -- let's go
    ImpPl1 = id SS ;

    -- ImpP3     : NP -> VP -> Utt ; -- let John walk
    ImpP3 = cc2 ;

-- 3/12/2013 non-reflexive uses of "self"

    -- SelfAdvVP : VP -> VP ;        -- is at home himself
    SelfAdvVP = id SS;
    -- SelfAdVVP : VP -> VP ;        -- is himself at home
    SelfAdVVP = id SS ;
    -- SelfNP    : NP -> NP ;        -- the president himself (is at home)
    SelfNP = id SS ;
-}
}
