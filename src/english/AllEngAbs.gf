--# -path=.:../abstract:../common:prelude

abstract AllEngAbs =
  -- the standard Grammar module
  Noun, Verb, Adjective, Adverb, Numeral, Sentence, Question, Relative, Conjunction, Phrase, Text, Idiom, Tense

  -- the large monolingual lexicon for English only. If you want to do wide-coverage parsing for multiple languages, use the Parse module at https://github.com/GrammaticalFramework/gf-wordnet
, DictEngAbs

 -- the Extend module
 -- comment out the following line (here and in the concrete), if too much ambiguity
 , Extend - [ProDrop, UseComp_estar, UseDAPFem, UseDAPMasc]

 ** {
  flags startcat=Phr ;
  }
