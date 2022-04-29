resource ParadigmsYrl = open CatYrl, ResYrl, Prelude in {

  oper

    VType : Type ;
    c1_noPron : VType ; -- C1
    c2_nci : VType ;    -- C2 NCI
    c2_ncs : VType ;    -- C2 NCS

    NType : Type ;
    ncs : NType ; -- wordform already contains possessor, e.g. uka 'house', suka 'his house'
    nci : NType ; -- need explicit pronoun for possessor, e.g. pirá 'fish', i pirá 'his fish'

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
    c1_noPron = C1 ;
    c2_nci = C2 NCI ;
    c2_ncs = C2 NCS ;

    NType = NClass ;
    ncs = NCS ; -- wordform already contains possessor, e.g. uka 'house', suka 'his house'
    nci = NCI ; -- need explicit pronoun for possessor, e.g. pirá 'fish', i pirá 'his fish'

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
      mkA : Str -> A = \s -> lin A (mkAdj s c2_nci) ;
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
