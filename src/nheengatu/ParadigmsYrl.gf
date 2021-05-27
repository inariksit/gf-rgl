resource ParadigmsYrl = open CatYrl, ResYrl, Prelude in {

  oper

    VType : Type ;
    noPron : VType ; -- C1
    nci : VType ;    -- C2 NCI
    ncs : VType ;    -- C2 NCS

    mkN : overload {
      mkN : Str -> N ;  -- regular noun, possessed with i: mkN "pirá"
      mkN : Str -> NClass -> N ; -- regular noun, give possession type explicitly: mkN "uka" NCS
      mkN : Str -> Str -> NClass -> N ; -- irregular noun: mkN "timbiú" "ximbiú" NCS
      } ;

    mkA : overload {
      mkA : Str -> A ;
      mkA : Str -> VType -> A
      } ;

    mkPN : overload {
      mkPN : Str -> PN ; -- Singular proper name
      mkPN : Str -> Number -> PN ; -- Proper name with number given explicitly
      } ;

--.
-- Definitions of opers

    VType = VClass ;
    noPron = C1 ;
    nci = C2 NCI ;
    ncs = C2 NCS ;

    mkN = overload {
      mkN : Str -> N = \n ->
        lin N (regNoun n) ;

      mkN : Str -> NClass -> N = \n,nc ->
        lin N (case nc of {
          NCS => relPrefNoun n ;
          _ => mkNoun n n n nc }) ;

      mkN : (x1,_,x3 : Str) -> NClass -> N = \a,b,c,nc ->
        lin N (mkNoun a b c nc)
      } ;

    mkA = overload {
      mkA : Str -> A = \s -> lin A (mkAdj s nci) ;
      mkA : Str -> VType -> A = \s,vt -> lin A (mkAdj s vt)
      } ;

    mkPN = overload {
      mkPN : Str -> PN = \s ->
        lin PN {s = s ; n = Sg} ;
      mkPN : Str -> Number -> PN = \s,n ->
        lin PN {s = s ; n = n}
      } ;

    param AClass = AC1 | AC2 ; -- TODO: figure this out
}
