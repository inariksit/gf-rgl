resource ResYrl = ParamX ** open Prelude, Predef in {


  ---------------------
  -- Phonology

  oper
    vowel : pattern Str = #("a"|"e"|"i"|"o"|"u"|"á"|"é"|"í"|"ó"|"ú") ;
    -- TODO: is ~ a nasal vowel marker and are they also vowels?


  ---------------------
  -- Nominal morphology
  oper
    Noun : Type = {
      s : NForm => Str ; -- We omit number, because -itá is easy to glue with BIND token
      nc : NClass ; -- When the noun is possessed, which possession strategy to use:
      } ;           -- * NCS: the wordform already contains info by whom it's possessed
                    --        e.g. uka 'house', suka 'his house'
                    -- * NCI: need to use explicit pronoun
                    --        e.g. pirá 'fish', i pirá 'his fish'

    mkNoun : (abs, nsg3, sg3 : Str) -> NClass -> Noun = \taiti,raiti,saiti,nc -> {
      s = table {
	NRel SG3  => saiti ;
	NRel NSG3 => raiti ;
	NAbs => taiti } ;
      nc = nc ;
      } ;

    relPrefNoun : Str -> Noun = \taiti ->
      let r_s_stem : Str*Str*Str = case taiti of {
            "t"|"s" + aiti
              => <"r", "s", aiti> ;  -- t+aiti, r+aiti, s+aiti
            #vowel + _
              => <"r", "s", taiti> ; -- uka, r+uka, s+uka
            _ => <"ra", "sa", taiti> -- pé, ra+pé, sa+pé
            } ;
          r = r_s_stem.p1 ;
          s = r_s_stem.p2 ;
          aiti = r_s_stem.p3 ;
       in mkNoun taiti (r+aiti) (s+aiti) NCS ;

    regNoun : Str -> Noun = \n -> mkNoun n n n NCI ;

    -- Postpositions also seem to behave like nouns. For now, we define
    mkPrep = overload {
      mkPrep : Str -> Noun = regNoun ;
      mkPrep : (ruaki,suaki : Str) -> Noun = \r,s -> mkNoun r r s NCS
      } ;

  param
    -- NForm: bare or possessed forms.
    -- tendaua ‘comunidade’
    -- sendaua ‘comunidade dele’
    -- se/iane/… rendaua ‘a minha/nossa/… comunidade’
    NForm = NAbs | NRel PsorForm ;
    PsorForm = SG3 | NSG3 ;

    NClass = NCI | NCS ;

  oper
    -- Pron may become an independent NP, or a possessive Quant
    -- Need to keep both options open in the lincat
    Pronoun : Type = { -- TODO: figure this out properly
      s : NClass => Str ; -- ixé vs. se
      a : Agr ;
      } ;

    mkPronoun : (nci, ncs : Str) -> Number -> Person -> Pronoun = \ixe,se,n,p -> {
      s = table {NCI => ixe ; NCS => se} ;
      a = Ag n p ;
      } ;

    NounPhrase : Type = Pronoun ** { -- NClass matters only for pronouns, but since NPs can be Prons and non-Prons, the parameter needs to be there.
      isPron : Bool ; -- TODO do we need this?
      } ;

    ProperName : Type = {
      s : Str ;
      n : Number ;
      } ;

  param
    Agr = Ag Number Person ;
    -- Number and Person are defined in ParamX

  oper
    Quantifier : Type = {
      s : Number => NClass => Str ; -- TODO check if this makes sense
      nf : NForm ; -- NRel pf for possessive pronouns, NAbs for other quantifiers (this, that, …)
      } ;

    Determiner : Type = {
      s : NClass => Str ;
      nf : NForm ;
      n : Number ; -- slightly redundant, NForm already contains some number info
      } ;

    mkQuant = overload {
      mkQuant : Str -> NForm -> Quantifier = \s,nf -> {
        s = \\_,_ => s ;
        nf = nf} ;
      mkQuant : (sg,pl : Str) -> NForm -> Quantifier = \sg,pl,nf -> {
        s = table {Sg => \\_ => sg ; Pl => \\_ => pl} ;
        nf = nf}
      };

    ag2psor : Agr -> PsorForm = \agr -> case agr of {
      Ag Sg P3 => SG3 ;
      _ => NSG3 } ;

  oper
    Num : Type = {
      s : Str ; -- TODO: may need revision after we introduce cardinal numbers
      n : Number ;
      } ;

    mkNum : Number -> Num = \n -> {s=[]; n=n} ;

  ---------------------
  -- Verbal morphology
  oper
    Verb : Type = { -- TODO: beyond present indicative
      s: Number => Person => Str
      } ;

    mkRegVerbYrl : Str -> Verb = \x -> {
      s = table {
	Sg => table {
	  P1 => "a"  + x ;
	  P2 => "re" + x ;
	  P3 => "u"  + x } ;
	Pl => table {
	  P1 => "ia" + x ;
	  P2 => "pe" + x ;
	  P3 => "u"  + x }
	}
      } ;

    StageLevelCopula : Verb = mkRegVerbYrl "iku" ;

  ---------------------
  -- VP and clause

  oper

    Complement : Type = {
      s : Agr => Str ;
      v : Verbal ;
      cc : CClass ;
      };

    VerbPhrase : Type = {
      s : Agr => Str ;
      cc : CClass ;
      v : Verbal ;
      l : Level ; -- whether to use *-iku or not
      } ;

    Clause : Type = {
      s : Polarity => Str ; -- TODO: tense, mood, etc.
      } ;

  param
    Verbal =      -- affects word order:
      IsVerbal    -- if verbal, pron ++ prop ++ cop.
      | NotVerbal -- otherwise: cop ++ pron ++ prop
      ;

    CClass =
      C1 -- no explicit pronoun (?)
      | C2 NClass -- secondClassPron
      ;

    Level =
      Ind      -- no copula
      | Stage  -- uses -iku as copula (like estar in Cat,Por,Spa)
      ;
    -- Analogamente a ser e estar em português,
    -- o nheengatu lexicaliza em orações predicativas a distinção entre
    -- * predicado de nível de indivíduo (individual level predicate) e
    -- * predicado de nível de fase (stage level predicate).
    -- Estes são marcados pelo auxiliar iku ‘estar’, enquanto aqueles não são marcados.
    -- (3) nhaã     t-imbiú     sepiasu retana
    --     DEM.DIST IMPR-comida caro    muito
    --     ‘aquela comida é muito cara’
    -- (4) kuá-itá     pirá  piranga  sepiasuíma u-iku
    --     DEM.PROX-PL peixe vermelho barato     3p.ACT-estar
    --     ‘estes peixes vermelhos estão baratos’

  oper
    YrlCopula : Number -> Person -> Level -> CClass -> Verbal -> (prop,pol : Str) -> Str =
      \n,p,l,cc,verbal,prop,pol ->
      let pron: Str = choosePron n p cc ;
          cop : Str = chooseCopula n p l ;
      in pol ++ wordOrder verbal pron prop cop ;

    wordOrder : Verbal -> (pron, prop, cop : Str) -> Str =
      \verbal,pron,prop,cop -> case verbal of {
        IsVerbal => pron ++ prop ++ cop ;
        NotVerbal => cop ++ pron ++ prop
      } ;


    choosePron : Number -> Person -> CClass -> Str = \num,pers,cc ->
      case cc of {
        C1    => "" ;
        C2 nc => SecondClassPron ! num ! pers ! nc
      } ;

    chooseCopula : Number -> Person -> Level -> Str = \n,p,l ->
      case l of {
        Stage => StageLevelCopula.s ! n ! p ;
        Ind => ""
      } ;


    SecondClassPron : Number => Person => NClass => Str = table {
      Sg => table { P1 => \\nc => "se" ;
        	    P2 => \\nc => "ne" ;
        	    P3 => table {NCI => "i"; NCS => ""}} ;

      Pl => table { P1 => \\nc => "iané" ;
        	    P2 => \\nc => "pe" ;
        	    P3 => \\nc => "aintá"|"ta"}
      } ;

}
