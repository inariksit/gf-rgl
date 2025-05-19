--# -path=.:../bangla:../common:../abstract:../prelude

resource SymbolicBen = Symbolic with
  (Symbol = SymbolBen),
  (Grammar = GrammarBen)
  ** open MissingBen in {} ;
