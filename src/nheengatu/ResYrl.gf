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
    NForm =
        NAbs -- uka 'house'
      | NRel PsorForm
      ;
    PsorForm =
        SG3  -- suka '3SG's house'
      | NSG3 -- se/iane/… ruka 'my/our/… house'
      ;

    -- NClass:
    -- * whether the noun has multiple forms, and
    -- * whether the noun takes 'i' or not when possessed by 3SG
    NClass =
        NCI -- uniform, takes i: pirá 'fish', i pirá '3SG's fish'
      | NCS -- multiform, no i:  uka 'house', suka '3SG's house'
      ;

  oper
    -- Pron may become an independent NP, or a possessive Quant
    -- Need to keep both options open in the lincat
    Pronoun : Type = { -- TODO: figure this out properly
      s : PForm => Str ; -- ixé vs. se
      a : Agr ;
      sg3poss: Str ; -- need this so there's some string for P3Sg pron to contibute,
                     -- otherwise we get metavariables:
      } ; -- https://inariksit.github.io/gf/2018/08/28/gf-gotchas.html#metavariables-or-those-question-marks-that-appear-when-parsing

    mkPronoun : (ixe, se : Str) -> Number -> Person -> Pronoun = \ixe,se,n,p -> {
      s = table {
            Full => ixe ;
            SecondClass => se} ;
      a = Ag n p ;
      sg3poss = [] ;
      } ;

    NounPhrase : Type = Pronoun ** { -- NClass matters only for pronouns, but since NPs can be Prons and non-Prons, the parameter needs to be there.
      isPron : Bool ;
      } ;

    baseNP : NounPhrase = {
      s = \\_ => [] ;
      a = Ag Sg P3 ;
      isPron = False ;
      sg3poss = [] ;
      } ;

    ProperName : Type = {
      s : Str ;
      n : Number ;
      } ;

  param
    -- TODO: figure out better names for these
    PForm =
        Full  -- ixé
      | SecondClass -- se
      ;

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
      s: Agr => Str
      } ;

    mkRegVerbYrl : Str -> Verb = \x -> {
      s = table {
        Ag Sg P1 => "a" + x ;
        Ag Sg P2 => "re" + x ;
        Ag Sg P3 => "u"  + x ;
        Ag Pl P1 => "ia" + x ;
        Ag Pl P2 => "pe" + x ;
        Ag Pl P3 => "u"  + x }
      } ;

    StageLevelCopula : Verb = mkRegVerbYrl "iku" ;

  ---------------------
  -- Adjective and AP

  oper
    Adjective : Type = {
      s : PsorForm => Str ; -- Adjectives may agree in 3SG-N3SG: suri, ruri
      c : VClass ; -- Whether to use second class pronoun or not: ∅ suri, i pusé
    } ;

    mkAdj : Str -> VClass -> Adjective = \ruri,vc -> {
      s = table {SG3 => suri ; NSG3 => ruri} ;
      c = vc ;
    } where {
      suri : Str = case <vc,ruri> of {
          <C2 NCS, "r" + uri> => "s" + uri ;
          _ => ruri } ;
    } ;
  ---------------------
  -- VP and clause

  oper

    Complement : Type = Adjective ** {
      v : Verbal ; -- Needed to get correct word order (IsVerbal for AP, NotVerbal for rest)
      };

    VerbPhrase : Type = {
      s : Agr => Str ;
      -- c : VClass ; -- Copula has already added, if the VP comes from Comp*
      -- v : Verbal ; -- TODO: do we need these for other verbs?
      l : Level ; -- The *-iku has already been applied (or not), but we need to retain info on Level to know whether to omit the subject or not.
      } ;

    Clause : Type = {
      s : Polarity => Str ; -- TODO: tense, mood, etc.
      } ;

  param
    Verbal =      -- affects word order:
      IsVerbal    -- if verbal, pron ++ prop ++ cop.
      | NotVerbal -- otherwise: cop ++ pron ++ prop
      ;

    -- Controls which version to use of subject pronoun, if not using stage level.
    -- If stage level, the subject pronoun is omitted.
    VClass =
        C1 -- When subject pronoun is used, it is always full form.
      | C2 NClass -- When subject clitic pronoun is used, which form to use
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
    YrlCopula : Agr -> Level -> VClass -> Verbal -> (prop : Str) -> Str =
      \agr,l,vc,verbal,prop ->
      let pron: Str = choosePron agr vc ;
          cop : Str = chooseCopula agr l ;
      in wordOrder verbal pron prop cop ;

    wordOrder : Verbal -> (pron, prop, cop : Str) -> Str =
      \verbal,pron,prop,cop -> case verbal of {
        IsVerbal => pron ++ prop ++ cop ;
        NotVerbal => cop ++ pron ++ prop
      } ;

    choosePron : Agr -> VClass -> Str = \agr,cc ->
      case cc of {
        C1    => "" ;
        C2 nc => SecondClassPron ! agr ! nc
      } ;

    chooseCopula : Agr -> Level -> Str = \agr,l ->
      case l of {
        Stage => StageLevelCopula.s ! agr ;
        Ind => ""
      } ;

    SecondClassPron : Agr => NClass => Str = table {
      Ag Sg P1 => \\nc => "se" ;
      Ag Sg P2 => \\nc => "ne" ;
      Ag Sg P3 => table {NCI => "i"; NCS => ""} ;
      Ag Pl P1 => \\nc => "iané" ;
      Ag Pl P2 => \\nc => "pe" ;
      Ag Pl P3 => \\nc => "ta"
      } ;

}
