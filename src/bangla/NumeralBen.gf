concrete NumeralBen of Numeral = CatBen [Numeral,Decimal,Digits] **
  open Prelude, ResBen in {
    
flags coding=utf8 ;


param 
  DForm = unit | ten ;
  DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ;
  Size = singl | less100 | more100 ; 

oper 
  LinDigit = {s : DForm => Str ; size : DSize ; n : Number ; ord : Str} ;
  LinDig : Type = {s : CardOrd => Str ; n : Number} ;

lincat 
  Dig = LinDig ;   -- single digit 0..9
  Digit = LinDigit ;
  Sub10 = {s : DForm => Str ; size : DSize ; n : Number ; ord : Str} ;
  Sub100 = {s : Str ; size : Size ; n : Number ; ord : Str} ;
  Sub1000 = {s : Str ; s2 : Str ; size : Size ; n : Number ; ord : Str} ; 
  Sub1000000,
  Sub1000000000, 
  Sub1000000000000 = {s : Str ; n : Number ; ord : Str} ;

lin num x0 = {
  s = table {
    NCard => x0.s ;
    NOrd  => x0.ord 
  } ;
  n = x0.n
} ;


oper mkDigits : Str -> Str -> Str -> DSize -> LinDigit = 
  \two -> \twenty -> \second -> \sz ->  
  {s = table {unit => two ; ten => twenty } ; 
   size = sz ; n = Pl ; ord = second } ;

lin n2 = mkDigits "দুই" "বিশ" "দ্বিতীয়" r2 ;
lin n3 = mkDigits "তিন" "ত্রিশ" "তৃতীয়" r3 ;
lin n4 = mkDigits "চার" "চল্লিশ" "চতুর্থ" r4 ;
lin n5 = mkDigits "পাঁচ" "পঞ্চাশ" "পঞ্চম" r5 ;
lin n6 = mkDigits "ছয়" "ষাট" "ষষ্ট" r6 ; 
lin n7 = mkDigits "সাত" "সত্তর" "সপ্তম" r7 ;
lin n8 = mkDigits "আট" "আশি" "অষ্টম" r8 ;
lin n9 = mkDigits "নয়" "নব্বই" "নবম" r9 ;

oper 
  mkR : (a1,_,_,_,_,_,_,_,a9 : Str) -> DSize => Str = 
   \a1,a2,a3,a4,a5,a6,a7,a8,a9 -> table {
     sg => a1 ; 
     r2 => a2 ;
     r3 => a3 ;
     r4 => a4 ;
     r5 => a5 ;
     r6 => a6 ;
     r7 => a7 ;
     r8 => a8 ;
     r9 => a9
    } ; 

  -- Ordinals from One - Hundred are irregular
  rows : DSize => DSize => Str = table {
    sg => mkR "এগারো" "একুশ" "একত্রিশ" "একচল্লিশ" "একান্ন" "একষট্টি" "একাত্তর" "একাশি" "একানব্বই" ;  
    r2 => mkR "বারো" "বাইশ" "বত্রিশ" "বেয়াল্লিশ" "বায়ান্ন" "বাষট্টি" "বাহাত্তর" "বিরাশি" "বিরানব্বই" ; 
    r3 => mkR "তেরো" "তেইশ" "তেত্রিশ" "তেতাল্লিশ" "তিয়ান্ন" "তেষট্টি" "তিয়াত্তর" "তিরাশি" "তিরানব্বই" ;
    r4 => mkR "চৌদ্দ" "চব্বিশ" "চৌত্রিশ" "চুয়াল্লিশ" "চুয়ান্ন" "চৌষট্টি" "চুয়াত্তর" "চুরাশি" "চুরানব্বই" ; 
    r5 => mkR "পনেরো" "পঁচিশ" "পঁয়ত্রিশ" "পঁয়তাল্লিশ" "পঞ্চান্ন" "পঁয়ষট্টি" "পঁচাত্তর" "পঁচাশি" "পঁচানব্বই" ; 
    r6 => mkR "ষোলো" "ছাব্বিশ" "ছত্রিশ" "ছিচল্লিশ" "ছিয়ান্ন" "ছেষট্টি" "ছিয়াত্তর" "ছিয়াশি" "ছিয়ানব্বই" ; 
    r7 => mkR "সতেরো" "সাতাশ" "সাঁইত্রিশ" "সাতচল্লিশ" "সাতান্ন" "সাতষট্টি" "সাতাত্তর" "সাতাশি" "সাতানব্বই" ; 
    r8 => mkR "আঠারো" "আঠাশ" "আটত্রিশ" "আটচল্লিশ" "আটান্ন" "আটষট্টি" "আটাত্তর" "অষ্টাশি" "আটানব্বই" ;
    r9 => mkR "উনিশ" "উনত্রিশ" "উনচল্লিশ" "উনপঞ্চাশ" "উনষাট" "উনসত্তর" "উনআশি" "উননব্বই" "নিরানব্বই" 
  } ;
  
  ss : Str -> {s : Str} = \s -> {s = s} ;

lin 
  pot01 = {s = table {unit => "এক" ; _ => "দশ" } ; size = sg ; n = Sg ; ord = "প্রথম" } ;
  pot0 d = d ; 
  pot110 = {s = "দশ" ; size = less100 ; n = Pl ; ord = "দশম" } ; 
  pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl ; ord = rows ! sg ! sg  ++ BIND ++ "তম" } ;
  pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = d.n ; ord = rows ! d.size ! sg ++ BIND ++ "তম" } ;
  pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n ; ord = n.ord } ;

  pot1 d = {s = d.s ! ten ; size = less100 ; n = d.n ; ord = d.s ! ten ++ BIND ++ "তম" } ;
  pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = d.n ; ord = rows ! e.size ! d.size ++ BIND ++ "তম" } ;

  pot1as2 n = {s = n.s ; s2 = n.s ; size = n.size ; n = n.n ; ord = n.ord } ;
  pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "লক্ষ" ; size = more100 ; n = d.n ;
              ord = (mksau (d.s ! unit) d.size) ++ BIND ++ "তম" } ;
  pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "লক্ষ" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = d.n ;
   ord = (mksau (d.s ! unit) d.size) ++ e.s ++ BIND ++ "তম" } ;

  pot2as3 n = {s = n.s ; n = n.n ; ord = n.ord } ;
  pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "হাজার" ; 
                          more100 => n.s2 } ! n.size ; n = n.n ;
              ord = table { singl => ekhazar ;
                          less100 => n.s ++ "হাজার" ; 
                          more100 => n.s2 } ! n.size ++ BIND ++ "তম" } ;
  pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "হাজার" ; 
              more100 => n.s2 } ! n.size ++ m.s ; n = n.n ;
   ord = table {singl => ekhazar ;
              less100 => n.s ++ "হাজার" ; 
              more100 => n.s2 } ! n.size ++ m.s ++ BIND ++ "তম" } ;
  pot3as4 n = n ;
  pot4as5 n = n ;

oper 
  ekhazar : Str = "এক" ++ "হাজার" ; 
  mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "হাজার"} ! sz ;
  mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "একশ" ; _ => s ++ BIND ++ "শ"} ! sz ;


lin
  -- : Dig -> Digits ;       -- 8
  IDig d = d ; 
  -- : Dig -> Digits -> Digits ; -- 876
  IIDig d e = {
  s = table {
    NCard => d.s ! NCard ++ BIND ++ e.s ! NCard ;
    NOrd => d.s ! NCard ++ BIND ++ e.s ! NCard ++ BIND ++ "তম" 
  } ;
  n = Pl ;
} ;
  -- : Dig ;
  D_0 = mkDig "০" "০তম" Sg ;
  D_1 = mkDig "১" "১ম" Sg ;
  D_2 = mkDig "২" "২য়" Pl ;
  D_3 = mkDig "৩" "৩য়" Pl ;
  D_4 = mkDig "৪" "৪র্থ" Pl ;
  D_5 = mkDig "৫" "৫ম" Pl ;
  D_6 = mkDig "৬" "৬ষ্ট" Pl ;
  D_7 = mkDig "৭" "৭ম" Pl ;
  D_8 = mkDig "৮" "৮ম" Pl ;
  D_9 = mkDig "৯" "৯ম" Pl ;

oper

  mkDig : Str -> Str -> Number -> LinDig = \s1, s2, n -> {
    s = table {
      NCard => s1 ;
      NOrd  => s2
      } ;
    n = n ;
    } ;

lin 

  PosDecimal d = { s = d.s ! NCard ; hasDot = False ; n = Pl } ;

  NegDecimal d = { s = "-" ++ BIND ++ d.s ! NCard ; hasDot = False ; n = Pl } ;

  IFrac d i = {
      s = d.s ++ if_then_Str d.hasDot BIND (BIND++"."++BIND) ++ i.s ! NCard ;
      hasDot=True;
      n = Pl
    } ;
}
