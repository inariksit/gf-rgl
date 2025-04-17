--# -path=.:../bangla:../common:../abstract:../prelude

resource TryBen = SyntaxBen-[mkAdN], LexiconBen, ParadigmsBen - [mkAdv,mkAdN,mkOrd,mkQuant,mkVoc, Prep] **
  open (P = ParadigmsBen) in {

oper

  mkAdv = overload SyntaxBen {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxBen.mkAdN ;
    mkAdN : Str -> AdN = P.mkAdN ;
  } ;

  mkOrd = overload SyntaxBen {
    mkOrd : Str -> Ord = P.mkOrd ;
  } ;


}
