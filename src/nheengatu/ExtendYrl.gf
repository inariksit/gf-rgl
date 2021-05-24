--1 Extensions of core RGL syntax (the Grammar module)

-- This module defines syntax rules that are not yet implemented in all
-- languages, and perhaps never implementable either. But all rules are given
-- a default implementation in common/ExtendFunctor.gf so that they can be included
-- in the library API. The default implementations are meant to be overridden in each
-- xxxxx/ExtendXxx.gf when the work proceeds.
--
-- This module is aimed to replace the original Extra.gf, which is kept alive just
-- for backwardcommon compatibility. It will also replace translator/Extensions.gf
-- and thus eliminate the often duplicated work in those two modules.
--
-- (c) Aarne Ranta 2017-08-20 under LGPL and BSD


concrete ExtendYrl of Extend = CatYrl ** open Prelude,(P=ParamX) in {

  lin
    
    -- GenNP       : NP -> Quant ;       -- this man's
    GenNP = id SS ;
    -- GenIP       : IP -> IQuant ;      -- whose
    GenIP = id SS ;
    -- GenRP       : Num -> CN -> RP ;   -- whose car
    GenRP = cc2 ;
    
-- In case the first two are not available, the following applications should in any case be.

    -- GenModNP    : Num -> NP -> CN -> NP ; -- this man's car(s)
    GenModNP = cc3 ;
    -- GenModIP    : Num -> IP -> CN -> IP ; -- whose car(s)
    GenModIP = cc3;
    
    -- CompBareCN  : CN -> Comp ;        -- (is) teacher
    CompBareCN = id SS ;
    
    -- StrandQuestSlash : IP -> ClSlash -> QCl ;   -- whom does John live with
    StrandQuestSlash = cc2;
    -- StrandRelSlash   : RP -> ClSlash -> RCl ;   -- that he lives in
    StrandRelSlash = cc2 ;
    -- EmptyRelSlash    : ClSlash       -> RCl ;   -- he lives in
    EmptyRelSlash = id SS ;

-- $VP$ conjunction, separate categories for finite and infinitive forms (VPS and VPI, respectively)
-- covering both in the same category leads to spurious VPI parses because VPS depends on many more tenses

  lincat
    VPS = SS ;           -- finite VP's with tense and polarity
    [VPS] = SS ;
    VPI = SS;
    [VPI] = SS ;     -- infinitive VP's (TODO: with anteriority and polarity)

  lin
    -- BaseVPS    : VPS -> VPS -> ListVPS ;
    BaseVPS = cc2 ;
    -- ConsVPS    : VPS -> ListVPS -> ListVPS ;
    ConsVPS = cc2 ;

    -- MkVPS      : Temp -> Pol -> VP -> VPS ;  -- hasn't slept
    MkVPS = cc3 ;
    -- ConjVPS    : Conj -> [VPS] -> VPS ;      -- has walked and won't sleep
    ConjVPS = cc2 ;
    -- PredVPS    : NP   -> VPS -> S ;          -- she [has walked and won't sleep]
    PredVPS = cc2 ;
    -- SQuestVPS  : NP   -> VPS -> QS ;         -- has she walked
    SQuestVPS = cc2 ;
    -- QuestVPS   : IP   -> VPS -> QS ;         -- who has walked
    QuestVPS = cc2 ;
    
-- existentials that work in the absence of Cl
    -- ExistS     : Temp -> Pol -> NP -> S ;    -- there was a party
    ExistS = cc3 ;
    -- ExistNPQS  : Temp -> Pol -> NP -> QS ;   -- was there a party
    ExistNPQS = cc3 ;
    -- ExistIPQS  : Temp -> Pol -> IP -> QS ;   -- what was there
    ExistIPQS = cc3 ;

    -- BaseVPI    : VPI -> VPI -> ListVPI ;
    BaseVPI = cc2 ;
    -- ConsVPI    : VPI -> ListVPI -> ListVPI ;
    ConsVPI = cc2 ;
    
    -- MkVPI      : VP -> VPI ;                 -- to sleep (TODO: Ant and Pol)
    MkVPI = id SS ;
    -- ConjVPI    : Conj -> [VPI] -> VPI ;      -- to sleep and to walk
    ConjVPI = cc2 ;
    -- ComplVPIVV : VV   -> VPI -> VP ;         -- must sleep and walk
    ComplVPIVV = cc2 ;
    
-- the same for VPSlash, taking a complement with shared V2 verbs

  lincat
    VPS2 = SS;        -- have loved (binary version of VPS)
    [VPS2] = SS ;  -- has loved, hates"
    VPI2 = SS;        -- to love (binary version of VPI)
    [VPI2] = SS ;  -- to love, to hate

  lin
    -- BaseVPS2    : VPS2 -> VPS2 -> ListVPS2 ;
    BaseVPS2 = cc2 ;
    -- ConsVPS2    : VPS2 -> ListVPS2 -> ListVPS2 ;
    ConsVPS2 = cc2 ;
    
    -- MkVPS2    : Temp -> Pol -> VPSlash -> VPS2 ;  -- has loved
    MkVPS2 = cc3 ;
    -- ConjVPS2  : Conj -> [VPS2] -> VPS2 ;          -- has loved and now hates
    ConjVPS2 = cc2 ;
    -- ComplVPS2 : VPS2 -> NP -> VPS ;               -- has loved and now hates that person
    ComplVPS2 = cc2 ;

    -- BaseVPI2  : VPI2 -> VPI2 -> ListVPI2 ;
    BaseVPI2 = cc2 ;
    -- ConsVPI2  : VPI2 -> ListVPI2 -> ListVPI2 ;
    ConsVPI2 = cc2 ;
    
    -- MkVPI2    : VPSlash -> VPI2 ;                 -- to love
    MkVPI2 = id SS ;
    -- ConjVPI2  : Conj -> [VPI2] -> VPI2 ;          -- to love and hate
    ConjVPI2 = cc2 ;
    -- ComplVPI2 : VPI2 -> NP -> VPI ;               -- to love and hate that person
    ComplVPI2 = cc2 ;
    
    -- ProDrop : Pron -> Pron ;  -- unstressed subject pronoun becomes empty: "am tired"
    ProDrop = id SS ;
    
    -- ICompAP : AP -> IComp ;   -- "how old"
    ICompAP = id SS ;
    -- IAdvAdv : Adv -> IAdv ;   -- "how often"
    IAdvAdv = id SS ;
    
    -- CompIQuant : IQuant -> IComp ;   -- which (is it) [agreement to NP]
    CompIQuant = id SS ;

    -- PrepCN     : Prep -> CN -> Adv ; -- by accident [Prep + CN without article]
    PrepCN = cc2 ;

  -- fronted/focal constructions, only for main clauses

    -- FocusObj : NP  -> SSlash  -> Utt ;   -- her I love
    FocusObj = cc2 ;
    -- FocusAdv : Adv -> S       -> Utt ;   -- today I will sleep
    FocusAdv = cc2 ;
    -- FocusAdV : AdV -> S       -> Utt ;   -- never will I sleep
    FocusAdV = cc2 ;
    -- FocusAP  : AP  -> NP      -> Utt ;   -- green was the tree
    FocusAP = cc2 ;

  -- participle constructions
    -- PresPartAP    : VP -> AP ;   -- (the man) looking at Mary
    PresPartAP = id SS ;
    -- EmbedPresPart : VP -> SC ;   -- looking at Mary (is fun)
    EmbedPresPart = id SS ;

    -- PastPartAP      : VPSlash -> AP ;         -- lost (opportunity) ; (opportunity) lost in space
    PastPartAP = id SS ;
    -- PastPartAgentAP : VPSlash -> NP -> AP ;   -- (opportunity) lost by the company
    PastPartAgentAP = cc2 ;

-- this is a generalization of Verb.PassV2 and should replace it in the future.

    -- PassVPSlash : VPSlash -> VP ; -- be forced to sleep
    PassVPSlash = id SS ;
    
-- the form with an agent may result in a different linearization
-- from an adverbial modification by an agent phrase.

    -- PassAgentVPSlash : VPSlash -> NP -> VP ;  -- be begged by her to go
    PassAgentVPSlash = cc2 ;
    
-- publishing of the document

    -- NominalizeVPSlashNP : VPSlash -> NP -> NP ;
    NominalizeVPSlashNP = cc2 ;
    
-- counterpart to ProgrVP, for VPSlash

    -- ProgrVPSlash : VPSlash -> VPSlash;
    ProgrVPSlash = id SS ;
    
-- existential for mathematics

    -- ExistsNP : NP -> Cl ;  -- there exists a number / there exist numbers
    ExistsNP = id SS ;
    
-- existentials with a/no variation

    -- ExistCN       : CN -> Cl ;  -- there is a car / there is no car
    ExistCN = id SS ;
    -- ExistMassCN   : CN -> Cl ;  -- there is beer / there is no beer
    ExistMassCN = id SS ;
    -- ExistPluralCN : CN -> Cl ;  -- there are trees / there are no trees
    ExistPluralCN = id SS ;

-- generalisation of existential, with adverb as a parameter
    -- AdvIsNP : Adv -> NP -> Cl ;  -- here is the tree / here are the trees
    AdvIsNP = cc2 ;
    -- AdvIsNPAP : Adv -> NP -> AP -> Cl ; -- here are the instructions documented
    AdvIsNPAP = cc3 ;
    
-- infinitive for purpose AR 21/8/2013

    -- PurposeVP : VP -> Adv ;  -- to become happy
    PurposeVP = id SS ;
    
-- object S without "that"

    -- ComplBareVS  : VS  -> S  -> VP ;       -- say she runs
    ComplBareVS = cc2 ;
    -- SlashBareV2S : V2S -> S  -> VPSlash ;  -- answer (to him) it is good
    SlashBareV2S = cc2 ;
    
    -- ComplDirectVS : VS -> Utt -> VP ;      -- say: "today"
    ComplDirectVS = cc2 ;
    -- ComplDirectVQ : VQ -> Utt -> VP ;      -- ask: "when"
    ComplDirectVQ = cc2 ;

-- front the extraposed part

    -- FrontComplDirectVS : NP -> VS -> Utt -> Cl ;      -- "I am here", she said
    FrontComplDirectVS = cc3 ;
    -- FrontComplDirectVQ : NP -> VQ -> Utt -> Cl ;      -- "where", she asked
    FrontComplDirectVQ = cc3 ;

-- proper structure of "it is AP to VP"

    -- PredAPVP : AP -> VP -> Cl ;      -- it is good to walk
    PredAPVP = cc2 ;

-- to use an AP as CN or NP without CN

    -- AdjAsCN : AP -> CN ;   -- a green one ; en grön (Swe)
    AdjAsCN = id SS ;
    -- AdjAsNP : AP -> NP ;   -- green (is good)
    AdjAsNP = id SS ;
    
-- infinitive complement for IAdv

    -- PredIAdvVP : IAdv -> VP -> QCl ; -- how to walk?
    PredIAdvVP = cc2 ;

-- alternative to EmbedQS. For English, EmbedQS happens to work,
-- because "what" introduces question and relative. The default linearization
-- could be e.g. "the thing we did (was fun)".

    -- EmbedSSlash : SSlash -> SC  ;   -- what we did (was fun)
    EmbedSSlash = id SS ;

-- reflexive noun phrases: a generalization of Verb.ReflVP, which covers just reflexive pronouns
-- This is necessary in languages like Swedish, which have special reflexive possessives.
-- However, it is also needed in application grammars that want to treat "brush one's teeth" as a one-place predicate.

  lincat
    RNP = SS;     -- reflexive noun phrase, e.g. "my family and myself"
    RNPList = SS; -- list of reflexives to be coordinated, e.g. "my family, myself, everyone"

-- Notice that it is enough for one NP in RNPList to be RNP.

  lin
    -- ReflRNP : VPSlash -> RNP -> VP ;   -- love my family and myself
    ReflRNP = cc2 ;
    
    -- ReflPron : RNP ;                   -- myself
    ReflPron = ss "" ;
    
    -- ReflPoss : Num -> CN -> RNP ;      -- my car(s)
    ReflPoss = cc2 ;
    
    -- PredetRNP : Predet -> RNP -> RNP ; -- all my brothers
    PredetRNP = cc2 ;
    
    -- ConjRNP : Conj -> RNPList -> RNP ;  -- my family, John and myself
    ConjRNP = cc2 ; 

    -- Base_rr_RNP : RNP -> RNP -> RNPList ;       -- my family, myself
    Base_rr_RNP = cc2 ;
    -- Base_nr_RNP : NP  -> RNP -> RNPList ;       -- John, myself
    Base_nr_RNP = cc2 ;
    -- Base_rn_RNP : RNP -> NP  -> RNPList ;       -- myself, John
    Base_rn_RNP = cc2 ;
    -- Cons_rr_RNP : RNP -> RNPList -> RNPList ;   -- my family, myself, John
    Cons_rr_RNP = cc2 ;
    -- Cons_nr_RNP : NP  -> RNPList -> RNPList ;   -- John, my family, myself
    Cons_nr_RNP = cc2 ;
----    Cons_rn_RNP : RNP -> ListNP  -> RNPList ;   -- myself, John, Mary

-- reflexive possessive on its own right, like in Swedish, Czech, Slovak

    -- ReflPossPron : Quant ;  -- Swe sin,sitt,sina
    ReflPossPron = ss "" ;
    
--- from Extensions

    -- ComplGenVV  : VV -> Ant -> Pol -> VP  -> VP ;         -- want not to have slept
    ComplGenVV vv ant pol vp =  cc2 (cc3 vv ant pol) vp ;
----  SlashV2V    : V2V -> Ant -> Pol -> VPS -> VPSlash ;   -- force (her) not to have slept

    -- CompoundN   : N -> N  -> N ;      -- control system / controls system / control-system
    CompoundN = cc2 ;
    -- CompoundAP  : N -> A  -> AP ;     -- language independent / language-independent
    CompoundAP = cc2 ;

    -- GerundCN    : VP -> CN ;          -- publishing of the document (can get a determiner)
    GerundCN = id SS ;
    -- GerundNP    : VP -> NP ;          -- publishing the document (by nature definite)
    GerundNP = id SS ;
    -- GerundAdv   : VP -> Adv ;         -- publishing the document (prepositionless adverb)
    GerundAdv = id SS ;

    -- WithoutVP   : VP -> Adv ;         -- without publishing the document
    WithoutVP = id SS ;
    -- ByVP        : VP -> Adv ;         -- by publishing the document
    ByVP = id SS ;
  -- InOrderToVP : VP -> Adv ;         -- (in order) to publish the document
    InOrderToVP = id SS ;
    
  -- ApposNP : NP -> NP -> NP ;        -- Mr Macron, the president of France,
    ApposNP = cc2 ;
    
    -- AdAdV       : AdA -> AdV -> AdV ;           -- almost always
    AdAdV = cc2 ;
    -- UttAdV      : AdV -> Utt ;                  -- always(!)
    UttAdV = id SS ;
  -- PositAdVAdj : A -> AdV ;                    -- (that she) positively (sleeps)
    PositAdVAdj = id SS ;
    
    -- CompS       : S -> Comp ;                   -- (the fact is) that she sleeps
    CompS = id SS ;
    -- CompQS      : QS -> Comp ;                  -- (the question is) who sleeps
    CompQS = id SS ;
    -- CompVP      : Ant -> Pol -> VP -> Comp ;    -- (she is) to go
    CompVP = cc3 ;

-- very language-specific things

-- Eng
    -- UncontractedNeg : Pol ;      -- do not, etc, as opposed to don't
    UncontractedNeg = { s = "do not" ; p = P.Neg } ;
    -- UttVPShort : VP -> Utt ;     -- have fun, as opposed to "to have fun"
    UttVPShort = id SS ;
    -- ComplSlashPartLast : VPSlash -> NP -> VP ; -- set it apart, as opposed to "set apart it"
    ComplSlashPartLast = cc2 ;

-- Romance
    -- DetNPMasc : Det -> NP ;
    DetNPMasc = id SS ;
    -- DetNPFem  : Det -> NP ;
    DetNPFem = id SS ;

    -- UseComp_estar : Comp -> VP ; -- (Cat, Spa, Por) "está cheio" instead of "é cheio"
    UseComp_estar = id SS ;

  -- SubjRelNP : NP -> RS -> NP ; -- Force RS in subjunctive: lo que les *resulte* mejor
    SubjRelNP = cc2 ;
    
    -- iFem_Pron      : Pron ; -- I (Fem)
    iFem_Pron = ss "" ;
  -- youFem_Pron    : Pron ; -- you (Fem)
    youFem_Pron = ss "" ;
    -- weFem_Pron     : Pron ; -- we (Fem)
    weFem_Pron = ss "" ;
    -- youPlFem_Pron  : Pron ; -- you plural (Fem)
    youPlFem_Pron = ss "" ;
    -- theyFem_Pron   : Pron ; -- they (Fem)
    theyFem_Pron = ss "" ;
    -- youPolFem_Pron : Pron ; -- you polite (Fem)
    youPolFem_Pron = ss "" ;
    -- youPolPl_Pron  : Pron ; -- you polite plural (Masc)
    youPolPl_Pron = ss "" ;
    -- youPolPlFem_Pron : Pron ; -- you polite plural (Fem)
    youPolPlFem_Pron = ss "" ;

-- German
    -- UttAccNP : NP -> Utt ; -- him (accusative)
    UttAccNP = id SS ;
    -- UttDatNP : NP -> Utt ; -- him (dative)
    UttDatNP = id SS ;
    -- UttAccIP : IP -> Utt ; -- whom (accusative)
    UttAccIP = id SS ;
    -- UttDatIP : IP -> Utt ; -- whom (dative)
    UttDatIP = id SS ;


}
