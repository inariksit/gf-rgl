--1 The construction of verb phrases

concrete VerbYrl of Verb = CatYrl ** open Prelude in{

  flags coding = utf8 ;

--2 Complementization rules

-- Verb phrases are constructed from verbs by providing their
-- complements. There is one rule for each verb category.

    {-
  lin
    -- UseV     : V   -> VP ;        -- sleep
    UseV = id SS ;

    -- ComplVV  : VV  -> VP -> VP ;  -- want to run
    ComplVV = cc2 ;
    -- ComplVS  : VS  -> S  -> VP ;  -- say that she runs
    ComplVS = cc2 ;
    -- ComplVQ  : VQ  -> QS -> VP ;  -- wonder who runs
    ComplVQ = cc2 ;
    -- ComplVA  : VA  -> AP -> VP ;  -- they become red
    ComplVA = cc2 ;

    -- SlashV2a : V2        -> VPSlash ;  -- love (it)
    SlashV2a = id SS ;
    -- Slash2V3 : V3  -> NP -> VPSlash ;  -- give it (to her)
    Slash2V3 = cc2 ;
    -- Slash3V3 : V3  -> NP -> VPSlash ;  -- give (it) to her
    Slash3V3 = cc2 ;

    -- SlashV2V : V2V -> VP -> VPSlash ;  -- beg (her) to go
    SlashV2V = cc2 ;
    -- SlashV2S : V2S -> S  -> VPSlash ;  -- answer (to him) that it is good
    SlashV2S = cc2 ;
    -- SlashV2Q : V2Q -> QS -> VPSlash ;  -- ask (him) who came
    SlashV2Q = cc2 ;
    -- SlashV2A : V2A -> AP -> VPSlash ;  -- paint (it) red
    SlashV2A = cc2 ;
    -- ComplSlash : VPSlash -> NP -> VP ; -- love it
    ComplSlash = cc2 ;

    -- SlashVV    : VV  -> VPSlash -> VPSlash ;       -- want to buy
    SlashVV = cc2 ;
    -- SlashV2VNP : V2V -> NP -> VPSlash -> VPSlash ; -- beg me to buy
    SlashV2VNP = cc3 ;

--2 Other ways of forming verb phrases

-- Verb phrases can also be constructed reflexively and from
-- copula-preceded complements.

    -- ReflVP   : VPSlash -> VP ;         -- love himself
    ReflVP = id SS ;
    -- UseComp  : Comp -> VP ;            -- be warm
    UseComp = id SS ;

-- Passivization of two-place verbs is another way to use
-- them. In many languages, the result is a participle that
-- is used as complement to a copula ("is used"), but other
-- auxiliary verbs are possible (Ger. "wird angewendet", It.
-- "viene usato"), as well as special verb forms (Fin. "käytetään",
-- Swe. "används").
--
-- *Note*. the rule can be overgenerating, since the $V2$ need not
-- take a direct object.

    -- PassV2   : V2 -> VP ;               -- be loved
    PassV2 = id SS ;

-- Adverbs can be added to verb phrases. Many languages make
-- a distinction between adverbs that are attached in the end
-- vs. next to (or before) the verb.

    -- AdvVP    : VP -> Adv -> VP ;        -- sleep here
    AdvVP = cc2 ;
    -- ExtAdvVP : VP -> Adv -> VP ;        -- sleep , even though ...
    ExtAdvVP = cc2 ;
    -- AdVVP    : AdV -> VP -> VP ;        -- always sleep
    AdVVP = cc2 ;

    -- AdvVPSlash : VPSlash -> Adv -> VPSlash ;  -- use (it) here
    AdvVPSlash = cc2 ;
    -- AdVVPSlash : AdV -> VPSlash -> VPSlash ;  -- always use (it)
    AdVVPSlash = cc2 ;

    -- VPSlashPrep : VP -> Prep -> VPSlash ;  -- live in (it)
    VPSlashPrep = cc2 ;

-- *Agents of passives* are constructed as adverbs with the
-- preposition [Structural Structural.html]$.8agent_Prep$.


--2 Complements to copula

-- Adjectival phrases, noun phrases, and adverbs can be used.

    -- CompAP   : AP  -> Comp ;            -- (be) small
    CompAP = id SS ;
    -- CompNP   : NP  -> Comp ;            -- (be) the man
    CompNP np = id SS ;
    -- CompAdv  : Adv -> Comp ;            -- (be) here
    CompAdv = id SS ;
    -- CompCN   : CN  -> Comp ;            -- (be) a man/men
    CompCN = id SS ;

-- Copula alone

    -- UseCopula : VP ;                    -- be
    UseCopula = ss "" ;
-}
}
