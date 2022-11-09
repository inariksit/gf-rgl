--# -path=.:../abstract:../common:../api

concrete AllEng of AllEngAbs =
  NounEng,
  VerbEng,
  AdjectiveEng,
  AdverbEng,
  NumeralEng,
  SentenceEng,
  QuestionEng,
  RelativeEng,
  ConjunctionEng,
  PhraseEng,
  TextX - [Pol,PPos,PNeg,SC,CAdv],
  IdiomEng,
  TenseX - [Pol,PPos,PNeg,SC,CAdv]

  -- the large monolingual lexicon
  , DictEng

  -- the Extend module
  -- comment out here and in the abstract, if too much ambiguity
  , ExtendEng - [ProDrop, UseComp_estar, UseDAPFem, UseDAPMasc]
  **   open Prelude, ResEng, ExtraEng --- to force compilation since this module is used in many places
  in {

flags startcat = Phr ;

lin
  PPos = {s = [] ; p = CPos} ;
  PNeg = {s = [] ; p = CNeg True} ; -- contracted: don't
}