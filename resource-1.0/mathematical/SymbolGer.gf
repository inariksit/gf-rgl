concrete SymbolGer of Symbol = CatGer ** open Prelude, ResGer in {

lin
  SymbPN i = {s = \\c => i.s ; g = Neutr} ; --- c
  IntPN i  = {s = \\c => i.s ; g = Neutr} ; --- c
  FloatPN i  = {s = \\c => i.s ; g = Neutr} ; --- c

  CNIntNP cn i = {
    s = \\c => cn.s ! Weak ! Sg ! Nom ++ i.s ;
    a = agrP3 Sg ;
    isPron = False
    } ;
  CNSymbNP det cn xs = let g = cn.g in {
    s = \\c => det.s ! g ! c ++ cn.s !  adjfCase det.a c ! det.n ! c ++ xs.s ; 
    a = agrP3 det.n ;
    isPron = False
    } ;

lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "und" ;
  ConsSymb = infixSS "," ;

}

