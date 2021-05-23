resource ParadigmsYrl = open CatYrl, ResYrl, Prelude in {

  oper

    mkN : overload {
      mkN : Str -> N ;  -- regular noun, possessed with i: mkN "pirá"
      mkN : Str -> NClass -> N ; -- regular noun, give possession type explicitly: mkN "uka" NCS
      mkN : Str -> Str -> NClass -> N ; -- irregular noun: mkN "timbiú" "ximbiú" NCS
      } ;

    mkA : overload {
      mkA : Str -> A ;
      mkA : Str -> AClass -> A
      } ;


--.
-- Definitions of opers

    mkN = overload {
      mkN : Str -> N = \n ->
        lin N (mkNoun n n n NCI) ;

      mkN : Str -> NClass -> N = \n,nc ->
        lin N (case nc of {
          NCS => relPrefNoun n ;
          _ => mkNoun n n n nc }) ;

      mkN : (x1,_,x3 : Str) -> NClass -> N = \a,b,c,nc ->
        lin N (mkNoun a b c nc)
      } ;

    mkA = overload {
      mkA : Str -> A = \s -> ss s ;
      mkA : Str -> AClass -> A = \s,_ -> ss s
      } ;

    param AClass = AC1 | AC2 ; -- TODO: figure this out
}
