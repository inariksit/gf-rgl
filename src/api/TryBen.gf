--# -path=.:../bangla:../common:../abstract:../prelude

resource TryBen = Prelude, SyntaxBen-[mkAdN], LexiconBen, ParadigmsBen - [mkAdv,mkAdN,mkOrd,mkQuant,mkVoc, Prep] **
  open (P = ParadigmsBen) in {

oper

  mkAdv = overload SyntaxBen {
    mkAdv : Str -> Adv = \s -> lin Adv (ss s) ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxBen.mkAdN ;
    mkAdN : Str -> AdN =  \s -> lin AdN (ss s)  ;
  } ;

  mkOrd = overload SyntaxBen {
    mkOrd : Str -> Ord =  \s -> lin Ord (ss s)  ;
  } ;


}
