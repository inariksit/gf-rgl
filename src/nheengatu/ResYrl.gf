resource ResYrl = ParamX ** open Prelude in {

  ---------------------
  -- Nominal morphology
  oper
    Noun : Type = {
      s : NForm => Str ; -- We omit number, because -itá is easy to glue with BIND token
      nc : NClass ;
      } ;

  param
    -- NForm: bare or possessed forms.
    -- tendaua ‘comunidade’
    -- sendaua ‘comunidade dele’
    -- se/iane/… rendaua ‘a minha/nossa/… comunidade’
    NForm = NAbs | NRel PsorForm ;
    PsorForm = SG3 | NSG3 ;

    -- NClass: controls the allomorphs i vs. s-
    -- Is this an example of this, or unrelated?
    -- i        igara i        pusé   u-iku
    -- 3s.INACT canoa 3s.INACT pesado 3s.ACT-estar
    -- ‘a canoa dele está pesada’
    -- vs.
    -- (ixé) se       pusé
    -- (eu)  1s.INACT pesado
    -- ‘(eu) sou pesado’
    NClass = NCI | NCS ;


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

    Level = Ind | Stage ;
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
