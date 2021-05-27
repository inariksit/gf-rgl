--1 Noun: Nouns, noun phrases, and determiners

concrete NounYrl of Noun = CatYrl ** open Prelude, ResYrl in {


--2 Noun phrases

-- The three main types of noun phrases are
-- - common nouns with determiners
-- - proper names
-- - pronouns
--
--
  lin
    -- DetCN   : Det -> CN -> NP ;   -- the man
    DetCN det cn = baseNP ** {
      s = \\_ => det.s ! cn.nc ++ cns ; -- "case" difference (ixé vs. se) only for Pron
      a = Ag det.n P3 ;
      } where {
         cns : Str = case det.n of {
           Sg => cn.s ! det.nf ;
           Pl => cn.s ! det.nf ++ BIND ++ "-itá" } ;
      } ;
   {- BIND token is  a way to glue strings together at runtime.
      In the normal GF shell, use the flag -bind to l:
         > l -bind DetCN (DetQuant IndefArt NumSg) (UseN house_N)
         uka-itá
      More info about BIND token: https://www.aclweb.org/anthology/W15-3305/ -}

    -- UsePN   : PN -> NP ;          -- John
    UsePN pn = baseNP ** {
      s = \\_ => pn.s ;
      a = Ag pn.n P3
      } ;

    -- UsePron : Pron -> NP ;        -- he
    UsePron pron = baseNP ** pron ** {
      isPron = True ;
      } ;

-- A noun phrase already formed can be modified by a $Predet$erminer.

    -- PredetNP : Predet -> NP -> NP ; -- only the man
    -- PredetNP = cc2 ;

-- A noun phrase can also be postmodified by the past participle of a
-- verb, by an adverb, or by a relative clause
{-
    -- PPartNP : NP -> V2  -> NP ;    -- the man seen
    PPartNP = cc2 ;
    -- AdvNP   : NP -> Adv -> NP ;    -- Paris today
    AdvNP = cc2 ;
    -- ExtAdvNP: NP -> Adv -> NP ;    -- boys, such as ..
    ExtAdvNP = cc2 ;
    -- RelNP   : NP -> RS  -> NP ;    -- Paris, which is here
    RelNP = cc2 ;
-- Determiners can form noun phrases directly.

    -- DetNP   : Det -> NP ;  -- these five
    DetNP = id SS ;
    -}

--2 Determiners

-- The determiner has a fine-grained structure, in which a 'nucleus'
-- quantifier and an optional numeral can be discerned.

    -- DetQuant    : Quant -> Num ->        Det ;  -- these five
    DetQuant quant num = quant ** {
      s = \\nc => quant.s ! num.n ! nc ++ num.s ;
      n = num.n
      } ;

    -- DetQuantOrd : Quant -> Num -> Ord -> Det ;  -- these five best
    -- DetQuantOrd = cc3 ;

-- Whether the resulting determiner is singular or plural depends on the
-- cardinal.

-- All parts of the determiner can be empty, except $Quant$, which is
-- the "kernel" of a determiner. It is, however, the $Num$ that determines
-- the inherent number.

    -- NumSg   : Num ;  -- [no numeral, but marked as singular]
    NumSg = mkNum Sg ;
    -- NumPl   : Num ;  -- [no numeral, but marked as plural]
    NumPl = mkNum Pl ;

{-

    -- NumCard : Card -> Num ; -- one/five [explicit numeral]
    NumCard = id SS ;

-- $Card$ consists of either digits or numeral words.

    --     NumDigits  : Digits  -> Card ;  -- 51
    NumDigits = id SS ;
    --     NumNumeral : Numeral -> Card ;  -- fifty-one
    NumNumeral = id SS ;

-- The construction of numerals is defined in [Numeral Numeral.html].

-- A $Card$ can  be modified by certain adverbs.

  -- lin
    -- AdNum : AdN -> Card -> Card ;   -- almost 51
    AdNum = cc2 ;
-- An $Ord$ consists of either digits or numeral words.
-- Also superlative forms of adjectives behave syntactically like ordinals.

    -- OrdDigits  : Digits  -> Ord ;  -- 51st
    OrdDigits = id SS ;
    -- OrdNumeral : Numeral -> Ord ;  -- fifty-first
    OrdNumeral = id SS ;
    -- OrdSuperl  : A       -> Ord ;  -- warmest
    OrdSuperl = id SS ;

-- One can combine a numeral and a superlative.

    -- OrdNumeralSuperl : Numeral -> A -> Ord ; -- third largest
    OrdNumeralSuperl = cc2 ;
    -}

-- Definite and indefinite noun phrases are sometimes realized as
-- neatly distinct words (Spanish "un, unos ; el, los") but also without
-- any particular word (Finnish; Swedish definites).

    -- IndefArt   : Quant ;  -- a/an
    IndefArt = mkQuant "" NAbs ;
    -- DefArt     : Quant ;  -- the
    DefArt = mkQuant "" NAbs ;

-- Nouns can be used without an article as mass nouns. The resource does
-- not distinguish mass nouns from other common nouns, which can result
-- in semantically odd expressions.

    -- MassNP : CN -> NP ;            -- (beer)
    -- MassNP = DetCN (DetQuant IndefArt NumSg)  ;

-- Pronouns have possessive forms. Genitives of other kinds
-- of noun phrases are not given here, since they are not possible
-- in e.g. Romance languages. They can be found in $Extra$ modules.

    -- PossPron : Pron -> Quant ;    -- my (house)
    PossPron pron = {
      s = \\num => case pron.a of {
        Ag Sg P3 => -- SG3: NCS form is empty, NCI is the second class form (i)
          table {
            NCS => pron.sg3poss ; -- empty string, must store it in pron to avoid metavariables
            NCI => pron.s ! SecondClass} ;
        _ =>       -- NSG3: second class form (ne,se,…) for possessing all nouns
          table {
            nc => pron.s ! SecondClass
          }
        } ;
      nf = NRel (ag2psor pron.a)
      } ;

    -- Other determiners are defined in Structural.



--2 Common nouns

-- Simple nouns can be used as nouns outright.

    -- UseN : N -> CN ;              -- house
    UseN n = n ;

-- Relational nouns take one or two arguments.
    -- ComplN2 : N2 -> NP -> CN ;    -- mother of the king
    ComplN2 = PossNP ;

    -- ComplN3 : N3 -> NP -> N2 ;    -- distance from this city (to Paris)
    --ComplN3 = cc2 ;

-- Relational nouns can also be used without their arguments.
-- The semantics is typically derivative of the relational meaning.

    -- UseN2   : N2 -> CN ;          -- mother
    UseN2 n = n ;
    -- Use2N3  : N3 -> N2 ;          -- distance (from this city)
{-    Use2N3 = id SS ;
    -- Use3N3  : N3 -> N2 ;          -- distance (to Paris)
    Use3N3 = id SS ;

-- Nouns can be modified by adjectives, relative clauses, and adverbs
-- (the last rule will give rise to many 'PP attachment' ambiguities
-- when used in connection with verb phrases).

    -- AdjCN   : AP -> CN  -> CN ;   -- big house
    AdjCN = cc2 ;
    -- RelCN   : CN -> RS  -> CN ;   -- house that John bought
    RelCN = cc2 ;
    -- AdvCN   : CN -> Adv -> CN ;   -- house on the hill
    AdvCN = cc2 ;

-- Nouns can also be modified by embedded sentences and questions.
-- For some nouns this makes little sense, but we leave this for applications
-- to decide. Sentential complements are defined in [Verb Verb.html].

    -- SentCN  : CN -> SC  -> CN ;   -- question where she sleeps
    SentCN = cc2 ;

--2 Apposition

-- This is certainly overgenerating.

    -- ApposCN : CN -> NP -> CN ;    -- city Paris (, numbers x and y)
    ApposCN = cc2 ;
--2 Possessive and partitive constructs

-}
    -- PossNP  : CN -> NP -> CN ;     -- house of Paris, house of mine
    PossNP cn np = cn ** {
      s = \\nf => nps ++ cn.s ! NRel pf
      } where {
        pf : PsorForm = case np.isPron of {
                          False => NSG3 ;
                          True => ag2psor np.a
                          } ;
        nps : Str = case <np.isPron, np.a, cn.nc> of {
          <True,
            Ag Sg P3,
            NCS> => np.sg3poss ; -- this empty string needs to come from the NP,
                                 -- othewise we get metavariables when parsing
          _ => np.s ! SecondClass }    -- https://inariksit.github.io/gf/2018/08/28/gf-gotchas.html#metavariables-or-those-question-marks-that-appear-when-parsing
      } ;

{-    -- PartNP  : CN -> NP -> CN ;     -- glass of wine
    PartNP = cc2 ;

-- This is different from the partitive, as shown by many languages.

    -- CountNP : Det -> NP -> NP ;    -- three of them, some of the boys
    CountNP = cc2 ;

--3 Conjoinable determiners and ones with adjectives

    -- AdjDAP : DAP -> AP -> DAP ;    -- the large (one)
    AdjDAP = cc2 ;
    -- DetDAP : Det -> DAP ;          -- this (or that)
    DetDAP = id SS ;
-}
}
