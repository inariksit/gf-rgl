--# -path=.:../abstract:../common

concrete SymbolAra of Symbol = CatAra ** open Prelude, ResAra in {


lin
  SymbPN i = mascSgAAgr ** {s = \\c => i.s} ; --IL
  IntPN i  = mascSgAAgr ** {s = \\c => i.s}  ; --IL
  FloatPN i = mascSgAAgr ** {s = \\c => i.s}  ; --IL
  NumPN i  = mascSgAAgr ** {s = \\c => uttNum i ! Masc} ; --IL
  -- CNIntNP cn i = {
  --   s = \\c => cn2str cn Sg Def c ++ uttNum i ! cn.g ;
  --   a = dummyAgrP3 Sg ;
  --   } ;
  --IL TODO: check out some opers regarding state in ResAra. These are just dummy values.
  CNSymbNP det cn xs =
    let g = cn.g ; n = sizeToNumber det.n in emptyNP ** {
    s = \\c => det.s ! NoHum ! g ! c ++ cn2str cn n Def c ++ xs.s; ----IL word order?? Seems to be nontrivial according to ResAra comments.
    a = NounPer3 {g=Masc ; n=n}
    } ;
  CNNumNP cn i = emptyNP ** {
    s = \\c => cn2str cn Sg Def c ++ uttNum i ! cn.g ;
    a = mascSg3Agr;
    } ;

  SymbS sy = {s = \\_ => sy.s} ;


  SymbOrd n = {s = \\_,_,_ => n.s ; n = One ; isNum = False } ;
  SymbNum n = SymbOrd n ** { n = ThreeTen ; isNum = True } ; ----IL

lincat

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "und" ; ----
  ConsSymb = infixSS "," ;

}
