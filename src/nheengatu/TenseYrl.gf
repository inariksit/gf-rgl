--1 Common: Structures with Common Implementations.

-- This module defines the abstract parameters of tense, polarity, and
-- anteriority, which are used in [``Phrase`` Phrase.html] to generate different
-- forms of sentences. Together they give 4 x 2 x 2 = 16 sentence forms.

-- These tenses are defined for all languages in the library. More tenses
-- can be defined in the language extensions, e.g. the "passe simple" of
-- Romance languages in [``ExtraRomance`` ../romance/ExtraRomance.gf].

-- For most languages [``TenseX`` ../common/TenseX.gf] can be used:
concrete TenseYrl of Tense = TenseX ;
-- If that is not possible implement the following module:
{-
  CommonX ** open (P=ParamX), Prelude in {

  lin
    
    -- TTAnt : Tense -> Ant -> Temp ;  -- [combination of tense and anteriority, e.g. past anterior]
    TTAnt tense ant = { s = tense.s ++ ant.s ; a = ant.a ; t = tense.t } ;
    -- PPos : Pol ;           -- I sleep  [positive polarity]
    PPos = { s = "" ; p = P.Pos } ;
    -- PNeg : Pol ;           -- I don't sleep [negative polarity]
    PNeg = { s = "" ; p = P.Neg } ;
    
    -- TPres  : Tense ;             -- I sleep/have slept [present]
    TPres = { s = "" ; t = P.Pres } ;
    -- ASimul : Ant ;               -- I sleep/slept [simultaneous, not compound]
    ASimul = { s = "" ; a = P.Simul } ;
    -- TPast  : Tense ;             -- I slept [past, "imperfect"]      --# notpresent
    TPast = { s = "" ; t = P.Past } ;
    -- TFut   : Tense ;             -- I will sleep [future] --# notpresent
    TFut = { s = "" ; t = P.Fut } ;
    -- TCond  : Tense ;             -- I would sleep [conditional] --# notpresent
    TCond = { s = "" ; t = P.Cond } ;
    -- AAnter : Ant ;               -- I have slept/had slept [anterior, "compound", "perfect"] --# notpresent
    AAnter = { s = "" ; a = P.Anter } ; 
}
-}
