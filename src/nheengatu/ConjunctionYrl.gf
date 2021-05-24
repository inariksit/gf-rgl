--1 Conjunction: Coordination

-- Coordination is defined for many different categories; here is
-- a sample. The rules apply to *lists* of two or more elements,
-- and define two general patterns:
-- - ordinary conjunction: X,...X and X
-- - distributed conjunction: both X,...,X and X
--
--
-- $VP$ conjunctions are not covered here, because their applicability
-- depends on language. Some special cases are defined in
-- [``Extra`` ../abstract/Extra.gf].

concrete ConjunctionYrl of Conjunction = CatYrl ** open Prelude, ResYrl in {

{-

--2 Rules

  lin

    -- ConjS    : Conj -> ListS -> S ;       -- he walks and she runs
    ConjS = cc2 ;
    -- ConjRS   : Conj -> ListRS -> RS ;     -- who walks and whose mother runs
    ConjRS = cc2 ;
    -- ConjAP   : Conj -> ListAP -> AP ;     -- cold and warm
    ConjAP = cc2 ;
    -- ConjNP   : Conj -> ListNP -> NP ;     -- she or we
    ConjNP = cc2 ;
    -- ConjAdv  : Conj -> ListAdv -> Adv ;   -- here or there
    ConjAdv = cc2 ;
    -- ConjAdV  : Conj -> ListAdV -> AdV ;   -- always or sometimes
    ConjAdV = cc2 ;
    -- ConjIAdv : Conj -> ListIAdv -> IAdv ; -- where and with whom
    ConjIAdv = cc2 ;
    -- ConjCN   : Conj -> ListCN -> CN ;     -- man and woman
    ConjCN = cc2 ;
    -- ConjDet  : Conj -> ListDAP -> Det ;   -- his or her
    ConjDet = cc2 ;

--2 Categories

-- These categories are only used in this module.

  lincat
    [S] = SS ;
    [RS] = SS ;
    [Adv] = SS ;
    [AdV] = SS ;
    [NP] = SS ;
    [AP] = SS ;
    [IAdv] = SS ;
    [CN] = SS ;
    [DAP] = SS ;

--2 List constructors


  lin
    -- BaseAP : AP -> AP -> ListAP ;       -- red, white
    BaseDAP = cc2 ;
    -- ConsAP : AP -> ListAP -> ListAP ;   -- red, white, blue
    ConsDAP = cc2 ;

    -- BaseAP : AP -> AP -> ListAP ;       -- red, white
    BaseAP = cc2 ;
    -- ConsAP : AP -> ListAP -> ListAP ;   -- red, white, blue
    ConsAP = cc2 ;

    -- BaseAdV : AdV -> AdV -> ListAdV ;     -- always, sometimes
    BaseAdV = cc2 ;
    -- ConsAdV : AdV -> ListAdV -> ListAdV ; -- always, sometimes, never
    ConsAdV = cc2 ;

    -- BaseAdv : Adv -> Adv -> ListAdv ;     -- here, there
    BaseAdv = cc2 ;
    -- ConsAdv : Adv -> ListAdv -> ListAdv ; -- here, there, everywhere
    ConsAdv = cc2 ;

    -- BaseCN : CN -> CN -> ListCN ;      -- man, woman
    BaseCN = cc2 ;
    -- ConsCN : CN -> ListCN -> ListCN ;  -- man, woman, child
    ConsCN = cc2 ;

    -- BaseIAdv : IAdv -> IAdv -> ListIAdv ;     -- where, when
    BaseIAdv = cc2 ;
    -- ConsIAdv : IAdv -> ListIAdv -> ListIAdv ; -- where, when, why
    ConsIAdv = cc2 ;

    -- BaseNP : NP -> NP -> ListNP ;      -- John, Mary
    BaseNP = cc2 ;
    -- ConsNP : NP -> ListNP -> ListNP ;  -- John, Mary, Bill
    ConsNP = cc2 ;

    -- BaseRS : RS -> RS -> ListRS ;       -- who walks, whom I know
    BaseRS = cc2 ;
    -- ConsRS : RS -> ListRS -> ListRS ;   -- who wals, whom I know, who is here
    ConsRS = cc2 ;

    -- BaseS : S -> S -> ListS ;      -- John walks, Mary runs
    BaseS = cc2 ;
    -- ConsS : S -> ListS -> ListS ;  -- John walks, Mary runs, Bill swims
    ConsS = cc2 ;
    -}

}
