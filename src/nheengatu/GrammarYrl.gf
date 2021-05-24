--1 Grammar: the Main Module of the Resource Grammar

-- This grammar is a collection of the different grammar modules,
-- To test the resource, import [``Lang`` Lang.html], which also contains
-- a lexicon.

concrete GrammarYrl of Grammar = 
  NounYrl
  , VerbYrl
  , AdjectiveYrl
  , AdverbYrl
  , NumeralYrl
  , SentenceYrl 
  , QuestionYrl
  , RelativeYrl
  , ConjunctionYrl
  , PhraseYrl
  , TextYrl
  , StructuralYrl
  , IdiomYrl
  , TenseYrl
--  , TransferYrl 
  ;

