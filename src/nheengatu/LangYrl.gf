--# -path=.:../abstract:../common:../api:../prelude

--1 Lang: a Test Module for the Resource Grammar

-- This grammar is for testing the resource as included in the
-- language-independent API, consisting of a grammar and a lexicon.
-- The grammar without a lexicon is [``Grammar`` Grammar.html],
-- which may be more suitable to open in applications.

concrete LangYrl of Lang = 
  GrammarYrl
, LexiconYrl
, ConstructionYrl  --- could be compiled here, but not in concretes, as they call Syntax and Grammar
-- , DocumentationYrl  --# notpresent
-- , MarkupYrl - [stringMark]
;
