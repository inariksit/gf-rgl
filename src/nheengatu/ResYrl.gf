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
      nc : NClass ; -- Which possession strategy to use: need to use explicit pronoun to
      } ;           -- either the wordform already contains info by whom it's possessed, or need to use explicit pronoun
                    -- i pirá 'his fish' vs. samunha 'his grandfather'

    mkNoun : (abs, nsg3, sg3 : Str) -> NClass -> Noun = \taiti,raiti,saiti,nc -> {
      s = table {
	NRel SG3  => saiti ;
	NRel NSG3 => raiti ;
	NAbs => taiti } ;
      nc = nc ;
      } ;

    relPrefNoun : Str -> Noun = \taiti ->
      let aiti : Str = case taiti of {
            "t" + aiti => aiti ;
            #vowel + _ => taiti ;
            _ => error ("relPrefNoun: expected bare form, got" ++ taiti) }
       in mkNoun taiti ("r"+aiti) ("s"+aiti) NCS ;

  param
    -- NForm: bare or possessed forms.
    -- tendaua ‘comunidade’
    -- sendaua ‘comunidade dele’
    -- se/iane/… rendaua ‘a minha/nossa/… comunidade’
    NForm = NAbs | NRel PsorForm ;
    PsorForm = SG3 | NSG3 ;

    -- NClass: controls the allomorphs i vs. s-
    NClass = NCI | NCS ;

  oper
    NounPhrase : Type = {
      s : NClass => Str ;
      isPron : Bool ;
      } ;

    -- Pron may become an independent NP, or a possessive Quant
    -- Need to keep both options open in the lincat
    Pronoun : Type = {
      s : Str
      } ;

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
      s : Number => Person => Str ;
      v : Verbal ;
      cc : CClass ;
      };

    VerbPhrase : Type = {
      s : Number => Person => Str ;
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
