resource ResBen = open Prelude, Predef in {

--------------------------------------------------------------------------------
-- General notes

-- ** Naming **
{-
I'm using the naming scheme for lincats and opers as explained here:
https://inariksit.github.io/gf/2018/08/28/gf-gotchas.html#my-naming-scheme-for-lincats-and-opers
-}

-- ** File structure **
-- The rest of this module is organised as follows:

      -----------------------------
      -- Grammatical categor(y|ies)

      {-
      General comments on the cat(s)

      params related to the cat(s)

      opers related to the cat(s)
      -}

--------------------------------------------------------------------------------
-- Nouns

{-The param Number comes from common/ParamX, and has the values Sg and Pl.
    * If your language doesn't have number, remove Number from all records.
    * If your language has number with more than 2 values, define your own number in this module
      (e.g. uncomment line 56) and use that Number instead of Number.

  The param Gender is defined here, and has the values Gender1 and Gender2.
  Currently it's only as a suggestion to be an inherent field in LinN.
    * If your language doesn't have gender, remove Gender from all records.
    * If your language has genders/noun classes, replace the placeholder Gender1 and Gender1
      with the actual values of your language (there can be more than 2!), and uncomment
      the g : Gender field from the definition of LinN.

  If your nouns inflect in more things, like case, you can do one of the following
    * Replace the placeholder cases on line 53 and make the table 2-dimensional, like this:
        oper LinN : Type = {s : Number => Case => Str ; …} ;
    * Make your own parameter that combines all the relevant features, like this:
        param NForm = Whatever | You | Need | For | Noun | Inflection ;
        oper LinN : Type = {s : NForm => Str ; …} ;
      This can be a good idea, if your inflection table has some gaps, i.e. not all combinations are in use
      See https://gist.github.com/inariksit/708ab9df2498e88bc63aedf5fc7be2f3#file-tables-gf-L48-L122 for explanation
 -}

param
  Case = Nom | Gen | Obj | Loc ;
  Number = Sg
         | Pl ;
  Article = Indefinite | Definite ;
  Animacy = Inanimate | Animate ;
  Person = P1 | P2H0 | P2H1 | P2H2 | P3H1 | P3H2 ;

oper
  LinN : Type = {
    s :
        Number =>    -- variable number: table {Sg => "house" ; Pl => "houses"}
        Article =>
        Case =>     -- uncomment if your language has case
        Str ;
    base : Str ;
    } ;

  mkLinN : Animacy -> Str -> LinN ;

  mkLinN animacy str = case animacy of {
        Animate => genLocSameN str ;
        Inanimate => nomObjSameN str 
  } ;

-- cc -table mkLinN Animate "বেদী"
  genLocSameN : Str -> LinN = \s -> {
        base = s ;
        s = table {
            Sg => table {
                Indefinite => table {
                   Nom => "একজন" ++ s ;
                   Obj => "একজন" ++ s + "কে" ;
                   Gen|Loc => case s of {
                    -- TODO Fix pattern matching
                    ? + ("ৌ" | "ৈ" | "া" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ")
                      => s + "য়ের" ;
                    _ + ("ৌ" | "ৈ" | "া" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ")
                      => s + "র" ;
                    _ + ("ই" | "ঈ" | "উ" | "ঊ" | "ঋ" | "এ" | "ঐ" | "ও" | "ঔ")
                      => s + "য়ের" ;
                    _ => s + " ের"
                   }
                } ;
                Definite => table {
                   Nom => s + "টা" ;
                   Obj => s + "টাকে" ;
                   Gen|Loc => s + "টার"
                }
            } ;
            Pl => table {
                Indefinite => table {
                   Nom => case s of {
                    ? + ("ৌ" | "ৈ" | "া" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ")
                      => s + "য়েরা" ;
                    _ + ("ৌ" | "ৈ" | "া" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ")
                      => s + "রা" ;
                    _ + ("ই" | "ঈ" | "উ" | "ঊ" | "ঋ" | "এ" | "ঐ" | "ও" | "ঔ")
                      => s + "য়েরা" ;
                    _ => s + " েরা"
                   } ;
                   Obj => s + "দেরকে" ;
                   Gen|Loc => s + "দের"
                } ;
                Definite => table {
                   Nom => s + "গুলো" ;
                   Obj => s + "গুলোকে" ;
                   Gen|Loc => s + "গুলোর"
                }
            }
        }
    } ;

nomObjSameN : Str -> LinN = \s -> {
        base = s ;
        s = table {
            Sg => table {
                Indefinite => table {
                   Nom|Obj => "একটা" ++ s ;
                   Gen => case s of {
                    ? + ("ৌ" | "ৈ" | "া" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ")
                      => "একটা" ++ s + "য়ের" ;
                    _ + ("ৌ" | "ৈ" | "া" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ")
                      => "একটা" ++ s + "র" ;
                    _ + ("ই" | "ঈ" | "উ" | "ঊ" | "ঋ" | "এ" | "ঐ" | "ও" | "ঔ")
                      => "একটা" ++ s + "য়ের" ;
                    _ => "একটা" ++ s + " ের"
                   } ;
                   Loc => "একটা" ++ s + " ে"
                } ;
                Definite => table {
                   Nom|Obj => s + "টা" ;
                   Gen => s + "টার" ;
                   Loc => s + "টায়"
                }
            } ;
            Pl => table {
                Indefinite => table {
                   Nom|Obj => s ;
                   Gen => case s of {
                    ? + ("ৌ" | "ৈ" | "া" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ")
                      => s + "য়ের" ;
                    _ + ("ৌ" | "ৈ" | "া" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ")
                      => s + "র" ;
                    _ + ("ই" | "ঈ" | "উ" | "ঊ" | "ঋ" | "এ" | "ঐ" | "ও" | "ঔ")
                      => s + "য়ের" ;
                    _ => s + " ের"
                   } ;
                   Loc => s + " ে"
                } ;
                Definite => table {
                   Nom|Obj => s + "গুলো" ;
                   Gen => s + "গুলোর" ;
                   Loc => s + "গুলোতে"  
                }
            }
        }
    } ;

  -- Most often, the lincat for CN is the same as N, with possibly some additional fields.
  -- However, sometimes you need more fields than just the s field, e.g. to keep word order flexible, or to add clitics and make sure they attach to the head, not modifiers.
  -- If you don't know what the previous line means, you can get started with just a single s field.
  -- You'll notice later whether you need such a field or not.
  LinCN : Type = LinN
    -- ** {postmod/premod/… : Str} -- if needed
    ;

  LinPN : Type = {
    s : Str ;
    n : Number ; -- Proper nouns often have already an inherent number; you don't usually say "a Paris / many Parises"
    -- g : Gender ; -- inherent gender/noun class, if your language has that
  } ;

  -- For inflection paradigms, see http://www.grammaticalframework.org/doc/tutorial/gf-tutorial.html#toc56
  -- mkNoun : Str -> LinN = \str -> {
  --   s = table {
  --     _ => str -- TODO: actual morphology
  --     } ;
      -- If your nouns have gender, it should come here as inherent field.
      -- Usually you need to give the gender as an argument to mkNoun.
    -- } ;

  -- linCN : LinCN -> Str = \cn -> cn.s ! Sg !TODO: Fix LinCN
                     --      ++ cn.postmod   -- If there is another field, use here
                                -- ;

---------------------------------------------
-- Numeral

-- Used in NumeralBen
  param
    CardOrd = NCard | NOrd ;

  oper
    LinNumeral : Type = {s : CardOrd => Str ; n : Number} ;

    mkNumeral : Str -> LinNumeral = \s -> {
      s = table {
        NCard => s ;
        NOrd  => s + "th"
        } ;
      n = Pl ; -- NB. probably singular for number 1
      } ;

---------------------------------------------
-- Pronoun

{-The param Person comes from common/ParamX, and has the values P1, P2 and P3.
    * If your language doesn't inflect in person, you may be able to remove Person from all records.
      - However, consider if it's really never present? How about e.g. reflexive ("myself", "yourself" etc?)
    * If your language is more fine-grained than {P1,P2,P3} x {Sg,Pl} (for instance gender and familiarity),
      you can define your own param. We provide an example called Agr to take inspiration from—remove if
      not needed, or use and refine if needed.
-}

-- param
  -- These params are just for inspiration, not used anywhere currently.
  -- Agr = SgP1             -- I
  --     | SgP2 Politeness  -- e.g. tū, tum, āp (Hindi) — note that the verb really inflects differently for all three!
  --     | SgP3 Gender      -- e.g. he, she (verb inflects the same, but distinction in reflexive: himself / herself)
  --     | FillInTheRestYourself ;
  -- Politeness = Intimate | Familiar | Polite ;

oper
  LinPron : Type = {
    s : Case => Str ;
    -- Alternative if your language has case and pronouns inflect in case (e.g. English I/me/my, she/her/hers)
    -- s : Case => Str ;
    n : Number ;
    p : Person ;
    -- Alternative to the `n` and `p` fields:
    -- a : Agr -- sketched above, lines 97-103
    } ;

  mkPron : (i, me, my, mine : Str) -> Person -> Number -> LinPron
   = \i, me, my, mine, per, num -> {
    s = table {
      Nom => i;
      Gen => me;
      Obj => my;
      Loc => mine
    } ;
    p = per ;
    n = num
    } ;

i_Pron = mkPron "আমি"	"আমার"	"আমাকে"	"আমার" P1 Sg ;
we_Pron = mkPron "আমরা"	"আমাদের"	"আমাদের"	"আমাদের" P1 Pl ;

youIntSg_Pron = mkPron "তুই"	"তোর"	"তোকে"	"তোর" P2H0 Sg ;
youIntPl_Pron = mkPron "তোরা"	"তোদের"	"তোদের"	"তোদের" P2H0 Pl ;
youSg_Pron = mkPron "তুমি" 	"তোমার"	"তোমাকে"	"তোমার" P2H1 Sg ;
youPl_Pron = mkPron "তোমরা"	"তোমাদের"	"তোমাদের"	"তোমাদের" P2H1 Pl ;
youPolSg_Pron = mkPron "আপনি"	"আপনার"	"আপনাকে"	"আপনার" P2H2 Sg ;
youPolPl_Pron = mkPron "আপনারা"	"আপনাদের"	"আপনাদের"	"আপনাদের" P2H2 Pl ;

he_Pron = mkPron "সে"	"তার"	"তাকে"	"তার" P3H1 Sg ;
she_Pron = he_Pron ;
they_Pron = mkPron "তারা"	"তাদের"	"তাদের"	"তাদের"	P3H1 Pl ;
hePol_Pron = mkPron "তিনি"	"তাঁর"	"তাঁকে"	"তাঁর" P3H2 Sg ;
shePol_Pron = hePol_Pron ;
theyPol_Pron = mkPron "তাঁরা"	"তাঁদের"	"তাঁদের"	"তাঁদের"	P3H2 Pl ;

it_Pron = mkPron "এটা" 	"এটার" 	"এটাকে"	"এটাতে"	P3H1 Sg ;
this_Pron = it_Pron ;
these_Pron = mkPron "এগুলো" "এগুলোর"	"এগুলোকে"	"এগুলোর"	P3H1 Pl ;
that_Pron = mkPron "ওটা" "ওটার" "ওটাকে" "ওটাতে" P3H1 Sg ;
those_Pron = mkPron "ওগুলো" "ওগুলোর" "ওগুলোকে" "ওগুলোর"	P3H1 Pl ;

-- who_RP who_IP
---------------------------------------------
-- NP

{-
In the RGL, a NP may come from a common noun, proper noun or pronoun.
Pronouns are the only ones that have an inherent person (nouns are almost always 3rd person! please give me counterexamples if you can think of any.)
So we can often say that NP's lincat is the same as Prons.

NB. for later, when you want to make Pron into possessives, you may need more fields in LinPron than in LinNP.
That's why I'm copying over the definition below, instead of the neater `LinNP : Type = LinPron`.
-}

  LinNP : Type = {
    s : Str ;
    -- Alternative: If anything inflects in case (nouns, pronouns), NP has to also inflect in case!
    -- s : Case => Str ;
    n : Number ;
    p : Person ;
    -- Alternative to the `n` and `p` fields:
    -- a : Agr -- sketched on lines 97-101
    } ;

  linNP : LinNP -> Str = \np -> np.s ; -- Change when you change LinNP

  emptyNP : LinNP = { -- Change when you change LinNP
    s = [] ;
    n = Sg ;
    p = P3H1 ;
  } ;

--------------------------------------------------------------------------------
-- Det, Quant, Card, Ord

  -- If your language has a number, it is very very very likely that
  -- Quant has a variable number and Det has inherent number.

  LinQuant : Type = {
    s,  -- quantifier in a context, e.g. 'this (cat) (is nice)'
    sp  -- quantifier as standalone, e.g. 'this (is nice)'
     : Number => Str ;
    } ;

  LinDet : Type = {
    s : Str ;
    n : Number ;
    } ;

  -- Can you reuse your mkNoun? Do nouns and quantifiers inflect the same way?
  mkQuant : Str -> Str -> LinQuant = \this, these -> {
    s,
    sp = table {
      Sg => this ;
      Pl => these } ;
    };

  mkDet : Str -> Number -> LinDet = \str, num -> {
    s = str ;
    n = num
  } ;

--------------------------------------------------------------------------------
-- Adpositions

{- The main use of Prep is in the fun

      PrepNP : Prep -> NP -> Adv

   Despite the name of the RGL category, a 'Prep' can be a preposition, postposition,
   or just an instruction to choose a particular case from the NP.
   A language may use one, two or all these strategies.

-}

oper
  LinPrep : Type = {
    s : Str ;

    -- If your language has cases, and different prepositions choose different cases.
    -- c2 : Case ;

    -- If your language has both pre- and postpositions, you need an inherent parameter in Prep to record which one a given Prep is.
    -- position : PreOrPost ;
    } ;


--------------------------------------------------------------------------------
-- Adjectives

  LinA : Type = SS ;
  LinA2 : Type = LinA ;

  mkAdj : Str -> LinA = \str -> {s = str} ;

  AdjPhrase : Type = LinA ; -- ** {compar : Str} ;
--------------------------------------------------------------------------------
-- Verbs
LinN : Type = {
    s :
        Number =>    -- variable number: table {Sg => "house" ; Pl => "houses"}
        Article =>
        Case =>     -- uncomment if your language has case
        Str ;
    } ;

  mkLinN : Animacy -> Str -> LinN ;

  mkLinN animacy str = case animacy of {
        Animate => genLocSameN str ;
        Inanimate => nomObjSameN str 
  } ;

param
  VForm = TODOVF Number Person ;
  Tense = PreSim | PreCon | PrePer | PaSim | PaCon | PaPer | FuSim ; 

oper
  LinV : Type = {
    s : 
        Tense => 
        Person => 
        Str ;
    } ;

  LinV2 : Type = LinV ** {
    c2 : LinPrep ;
    } ;

  mkVerb : Str -> Str -> LinV ; 
  
  mkVerb low high = case low of {
    ? + "া" => cls4mkVerb low high ;
    ? + ("ৌ" | "ৈ" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ") => cls3mkVerb low high ;
    ? + "া" + ? | "আ" + ? => cls2mkVerb low high ;
    ? + ("ৌ" | "ৈ" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ") + ? |
    ? + ? | ("অ" | "ই" | "ঈ" | "উ" | "ঊ" | "ঋ" | "এ" | "ঐ" | "ও" | "ঔ") + ? => cls1mkVerb low high ;
    ? + ("া" | "ৌ" | "ৈ" | "ী" | "ূ" | "ো" | "ে" | "্" | "ি" | "ু" | "ৃ") + ? + "া" => cls5mkVerb low high ;
    _ => cls6mkVerb low high 
  } ;

  cls1mkVerb : (low, high : Str) -> LinV
   = \low, high -> {
    s = table {
      PreSim => table {
        P1 => high + "ি" ;
        P2H1 => low ;
        P2H0 => high + "িস" ;
        P3H1 => low + "ে" ;
        P2H2 | P3H2 => low + "েন" 
      } ;
      PreCon => table {
        P1 => high + "ছি" ;
        P2H1 => high + "ছো" ;
        P2H0 => high + "ছিস" ;
        P3H1 => high + "ছে" ;
        P2H2 | P3H2 => high + "ছেন"
      } ;
      PrePer => table {
        P1 => high + "েছি" ;
        P2H1 => high + "েছো" ;
        P2H0 => high + "েছিস" ;
        P3H1 => high + "েছে" ;
        P2H2 | P3H2 => high + "েছেন"
      } ;
      PaSim => table {
        P1 => high + "লাম" ;
        P2H1 => high + "লে" ;
        P2H0 => high + "লি" ;
        P3H1 => high + "লো" ;
        P2H2 | P3H2 => high + "লেন"
      } ;
      PaCon => table {
        P1 => high + "ছিলাম" ;
        P2H1 => high + "ছিলে" ;
        P2H0 => high + "ছিলি" ;
        P3H1 => high + "ছিলো" ;
        P2H2 | P3H2 => high + "ছিলেন"
      } ;
      PaPer => table {
        P1 => high + "েছিলাম" ;
        P2H1 => high + "েছিলে" ;
        P2H0 => high + "েছিলি" ;
        P3H1 => high + "েছিলো" ;
        P2H2 | P3H2 => high + "েছিলেন"
      } ;
      FuSim => table {
        P1 => high + "বো" ;
        P2H1 => high + "বে" ;
        P2H0 => high + "বি" ;
        P3H1 => high + "বে" ;
        P2H2 | P3H2 => high + "বেন"
      } 
    } ;
   } ;
  
  cls2mkVerb : (low, high : Str) -> LinV
   = \low, high -> {
    s = table {
      PreSim => table {
        P1 => low + "ি" ;
        P2H1 => low ;
        P2H0 => low + "িস" ;
        P3H1 => low + "ে" ;
        P2H2 | P3H2 => low + "েন" 
      } ;
      PreCon => table {
        P1 => low + "ছি" ;
        P2H1 => low + "ছো" ;
        P2H0 => low + "ছিস" ;
        P3H1 => low + "ছে" ;
        P2H2 | P3H2 => low + "ছেন"
      } ;
      PrePer => table {
        P1 => high + "েছি" ;
        P2H1 => high + "েছো" ;
        P2H0 => high + "েছিস" ;
        P3H1 => high + "েছে" ;
        P2H2 | P3H2 => high + "েছেন"
      } ;
      PaSim => table {
        P1 => low + "লাম" ;
        P2H1 => low + "লে" ;
        P2H0 => low + "লি" ;
        P3H1 => low + "লো" ;
        P2H2 | P3H2 => low + "লেন"
      } ;
      PaCon => table {
        P1 => low + "ছিলাম" ;
        P2H1 => low + "ছিলে" ;
        P2H0 => low + "ছিলি" ;
        P3H1 => low + "ছিলো" ;
        P2H2 | P3H2 => low + "ছিলেন"
      } ;
      PaPer => table {
        P1 => high + "েছিলাম" ;
        P2H1 => high + "েছিলে" ;
        P2H0 => high + "েছিলি" ;
        P3H1 => high + "েছিলো" ;
        P2H2 | P3H2 => high + "েছিলেন"
      } ;
      FuSim => table {
        P1 => low + "বো" ;
        P2H1 => low + "বে" ;
        P2H0 => low + "বি" ;
        P3H1 => low + "বে" ;
        P2H2 | P3H2 => low + "বেন"
      } 
    } ;
   } ;

  cls3mkVerb : (low, high : Str) -> LinV
   = \low, high -> {
    s = table {
      PreSim => table {
        P1 => high + "ই" ;
        P2H1 => low + "ও" ;
        P2H0 => high + "স" ;
        P3H1 => low + "য়" ;
        P2H2 | P3H2 => low + "ন" 
      } ;
      PreCon => table {
        P1 => high + "চ্ছি" ;
        P2H1 => high + "চ্ছো" ;
        P2H0 => high + "চ্ছিস" ;
        P3H1 => high + "চ্ছে" ;
        P2H2 | P3H2 => high + "চ্ছেন"
      } ;
      PrePer => table {
        P1 => high + "য়েছি" ;
        P2H1 => high + "য়েছ" ;
        P2H0 => high + "য়েছিস" ;
        P3H1 => high + "য়েছে" ;
        P2H2 | P3H2 => high + "য়েছেন"
      } ;
      PaSim => table {
        P1 => high + "লাম" ;
        P2H1 => high + "লে" ;
        P2H0 => high + "লি" ;
        P3H1 => high + "লো" ;
        P2H2 | P3H2 => high + "লেন"
      } ;
      PaCon => table {
        P1 => high + "চ্ছিলাম" ;
        P2H1 => high + "চ্ছিলে" ;
        P2H0 => high + "চ্ছিলি" ;
        P3H1 => high + "চ্ছিলো" ;
        P2H2 | P3H2 => high + "চ্ছিলেন"
      } ;
      PaPer => table {
        P1 => high + "য়েছিলাম" ;
        P2H1 => high + "য়েছিলে" ;
        P2H0 => high + "য়েছিলি" ;
        P3H1 => high + "য়েছিলো" ;
        P2H2 | P3H2 => high + "য়েছিলেন"
      } ;
      FuSim => table {
        P1 => high + "বো" ;
        P2H1 => high + "বে" ;
        P2H0 => high + "বি" ;
        P3H1 => high + "বে" ;
        P2H2 | P3H2 => high + "বেন"
      } 
    } ;
   } ;

  cls4mkVerb : (low, high : Str) -> LinV
   = \low, high -> {
    s = table {
      PreSim => table {
        P1 => low + "ই" ;
        P2H1 => low + "ও" ;
        P2H0 => low + "স" ;
        P3H1 => low + "য়" ;
        P2H2 | P3H2 => low + "ন" 
      } ;
      PreCon => table {
        P1 => low + "চ্ছি" ;
        P2H1 => low + "চ্ছো" ;
        P2H0 => low + "চ্ছিস" ;
        P3H1 => low + "চ্ছে" ;
        P2H2 | P3H2 => low + "চ্ছেন"
      } ;
      PrePer => table {
        P1 => high + "য়েছি" ;
        P2H1 => high + "য়েছো" ;
        P2H0 => high + "য়েছিস" ;
        P3H1 => high + "য়েছে" ;
        P2H2 | P3H2 => high + "য়েছেন"
      } ;
      PaSim => table {
        P1 => high + "লাম" ;
        P2H1 => high + "লে" ;
        P2H0 => high + "লি" ;
        P3H1 => high + "লো" ;
        P2H2 | P3H2 => high + "লেন"
      } ;
      PaCon => table {
        P1 => low + "চ্ছিলাম" ;
        P2H1 => low + "চ্ছিলে" ;
        P2H0 => low + "চ্ছিলি" ;
        P3H1 => low + "চ্ছিলো" ;
        P2H2 | P3H2 => low + "চ্ছিলেন"
      } ;
      PaPer => table {
        P1 => high + "য়েছিলাম" ;
        P2H1 => high + "য়েছিলে" ;
        P2H0 => high + "য়েছিলি" ;
        P3H1 => high + "য়েছিলো" ;
        P2H2 | P3H2 => high + "য়েছিলেন"
      } ;
      FuSim => table {
        P1 => low + "বো" ;
        P2H1 => low + "বে" ;
        P2H0 => low + "বি" ;
        P3H1 => low + "বে" ;
        P2H2 | P3H2 => low + "বেন"
      } 
    } ;
   } ;

  cls5mkVerb = cls4mkVerb ;
  cls6mkVerb = cls4mkVerb ;

  -- copula : LinV = {s = \\_ => "TODO: copula"} ; TODO -- often useful

------------------
-- VP

  LinVP : Type = {
    s : VForm => Str ;
    } ;

  LinVPSlash : Type = LinVP ** {
    c2 : LinPrep ;
    } ;

  -- linVP : LinVP -> Str = \vp -> vp.s ! TODOVF Sg P3 ; //TODO

--------------------------------------------------------------------------------
-- Cl, S

  -- Operations for clauses, sentences
  LinCl : Type = {
    subj : Str ;
    pred : Str ; -- TODO: depend on Temp and Pol
  } ;

  linCl : LinCl -> Str = \cl -> cl.subj ++ cl.pred ;

}
