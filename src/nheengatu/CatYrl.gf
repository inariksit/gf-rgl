concrete CatYrl of Cat = CommonX ** open Prelude, ResYrl, (R=ResYrl) in {

  lincat

--2 Sentences and clauses

-- Constructed in [Sentence Sentence.html], and also in
-- [Idiom Idiom.html].

    S = SS ;        -- declarative sentence                e.g. "she lived here"
    QS = SS ;       -- question                            e.g. "where did she live"
    RS = SS ;       -- relative                            e.g. "in which she lived"
    Cl = Clause ;       -- declarative clause, with all tenses e.g. "she looks at this"
    ClSlash = SS ;  -- clause missing NP (S/NP in GPSG)    e.g. "she looks at"
    SSlash = SS ;   -- sentence missing NP                 e.g. "she has looked at"
    Imp = SS ;      -- imperative                          e.g. "look at this"

--2 Questions and interrogatives

-- Constructed in [Question Question.html].

    QCl = SS ;      -- question clause, with all tenses    e.g. "why does she walk"
    IP = SS ;       -- interrogative pronoun               e.g. "who"
    IComp = SS ;    -- interrogative complement of copula  e.g. "where"
    IDet = SS ;     -- interrogative determiner            e.g. "how many"
    IQuant = SS ;   -- interrogative quantifier            e.g. "which"

--2 Relative clauses and pronouns

-- Constructed in [Relative Relative.html].

    RCl = SS ;      -- relative clause, with all tenses    e.g. "in which she lives"
    RP = SS ;       -- relative pronoun                    e.g. "in which"

--2 Verb phrases

-- Constructed in [Verb Verb.html].

    VP = VerbPhrase ;       -- verb phrase                       e.g. "is very warm"
    Comp = Complement ;     -- complement of copula, such as AP  e.g. "very warm"
    VPSlash = SS ;  -- verb phrase missing complement    e.g. "give to John"

--2 Adjectival phrases

-- Constructed in [Adjective Adjective.html].

    AP = Adjective ;  -- adjectival phrase                   e.g. "very warm"

--2 Nouns and noun phrases

-- Constructed in [Noun Noun.html].
-- Many atomic noun phrases e.g. "everybody"
-- are constructed in [Structural Structural.html].
-- The determiner structure is
-- ``` Predet (QuantSg | QuantPl Num) Ord
-- as defined in [Noun Noun.html].

    CN = Noun ;       -- common noun (without determiner)    e.g. "red house"
    NP = NounPhrase ; -- noun phrase (subject or object)     e.g. "the red house"
    Pron = Pronoun ;     -- personal pronoun                    e.g. "she"
    Det = Determiner ;      -- determiner phrase                   e.g. "those seven"
    Predet = SS ;   -- predeterminer (prefixed Quant)      e.g. "all"
    Quant = Quantifier ;    -- quantifier ('nucleus' of Det)       e.g. "this/these"
    Num = R.Num ;  -- number determining element          e.g. "seven"
    Card = SS ;     -- cardinal number                     e.g. "seven"
    ACard = SS ;    -- adjective like cardinal             e.g. "few", "many"
    Ord = SS ;      -- ordinal number (used in Det)        e.g. "seventh"
    DAP = SS ;      -- determiner with adjective           e.g. "three small"

--2 Numerals

-- Constructed in [Numeral Numeral.html].

    Numeral = SS ;  -- cardinal or ordinal in words       e.g. "five/fifth"
    Digits = SS ;   -- cardinal or ordinal in digits      e.g. "1,000/1,000th"

--2 Structural words

-- Constructed in [Structural Structural.html].

    Conj = SS ;     -- conjunction                         e.g. "and"
    Subj = SS ;     -- subjunction                         e.g. "if"
    Prep = Noun ;     -- preposition, or just case           e.g. "in"
    -- Postpositions behave like nouns: suaki 'near 3SG' / ruaki 'near

--2 Words of open classes

-- These are constructed in [Lexicon Lexicon.html] and in
-- additional lexicon modules.

    V = SS ;        -- one-place verb                      e.g. "sleep"
    V2 = SS ;       -- two-place verb                      e.g. "love"
    V3 = SS ;       -- three-place verb                    e.g. "show"
    VV = SS ;       -- verb-phrase-complement verb         e.g. "want"
    VS = SS ;       -- sentence-complement verb            e.g. "claim"
    VQ = SS ;       -- question-complement verb            e.g. "wonder"
    VA = SS ;       -- adjective-complement verb           e.g. "look"
    V2V = SS ;      -- verb with NP and V complement       e.g. "cause"
    V2S = SS ;      -- verb with NP and S complement       e.g. "tell"
    V2Q = SS ;      -- verb with NP and Q complement       e.g. "ask"
    V2A = SS ;      -- verb with NP and AP complement      e.g. "paint"

    A = Adjective ;        -- one-place adjective                 e.g. "warm"
    A2 = SS ;       -- two-place adjective                 e.g. "divisible"

    N = Noun ;        -- common noun                         e.g. "house"
    N2 = Noun ;       -- relational noun                     e.g. "son"
    N3 = SS ;       -- three-place relational noun         e.g. "connection"
    PN = ProperName ;  -- proper name                         e.g. "Paris"


}
