--# -path=.:../abstract:../common:../api:../prelude

concrete AllYrl of AllYrlAbs =
  LangYrl,
  ExtraLexiconYrl,
  ExtendYrl
  ** {} ;
