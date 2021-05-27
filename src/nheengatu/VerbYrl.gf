--1 The construction of verb phrases

concrete VerbYrl of Verb = CatYrl ** open Prelude, ResYrl in {

  flags coding = utf8 ;

--2 Complementization rules

-- Verb phrases are constructed from verbs by providing their
-- complements. There is one rule for each verb category.


  lin
    {-
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
-}
    -- UseComp  : Comp -> VP ;            -- be warm
    -- NB. This rule only produces individual level VP.
    -- For stage level, use Extend.UseComp_estar.
    -- The purpose of the RGL is to provide a range of syntactic structures, and
    -- an application grammarian can choose which one to use for a given communicative need.
    UseComp comp = {
      s = \\agr =>
        YrlCopula agr Ind comp.c comp.v (comp.s ! ag2psor agr)  ;
      l = Ind ;
      };

{-
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

-}
--2 Complements to copula

-- Adjectival phrases, noun phrases, and adverbs can be used.

    -- CompAP   : AP  -> Comp ;            -- (be) small
    CompAP ap = ap ** {v = IsVerbal} ;

    -- CompAdv  : Adv -> Comp ;            -- (be) here
    CompAdv adv = {
      s = \\_ => adv.s ; -- no agreement in Advs
      v = NotVerbal ;
      c = C1 ;
      } ;

 {-
    -- TODO: how to make NP into a predicative?
    -- CompNP   : NP  -> Comp ;            -- (be) the man
    CompNP np = {
      s = np.s ! Full ; -- TODO: do we need to put agr stuff already here?
      v = NotVerbal ;
      c = ?
      } ;
    -- CompCN   : CN  -> Comp ;            -- (be) a man/men
    CompCN = id SS ;

-- Copula alone

    -- UseCopula : VP ;                    -- be
    --UseCopula = ss "" ;
-}
}
