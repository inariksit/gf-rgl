--# -path=.:alltenses:prelude

resource CombinatorsBen = Combinators - [ appCN, appCNc ] with 
  (Cat = CatBen),
  (Structural = StructuralBen),
  (Noun = NounBen),
  (Constructors = ConstructorsBen) ** open MissingBen in
  {
  	oper
	appCN : CN -> NP -> NP
           = \cn,x -> mkNP the_Art (PossNP cn x) ;
    appCNc : CN -> [NP] -> NP
           = \cn,xs -> let np : NP = mkNP and_Conj xs
                       in mkNP the_Art (PossNP cn np) ; 
  }
