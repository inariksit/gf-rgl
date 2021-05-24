--1 Symbolic expressions

-- *Note*. This module is not automatically included in the main
-- grammar [Lang Lang.html].

concrete SymbolYrl of Symbol = CatYrl, PredefAbs, Prelude ** {

--2 Noun phrases with symbols and numbers

  lin

    -- SymbPN   : Symb -> PN ;                -- x
    SymbPN = id SS ;
    -- IntPN    : Int -> PN ;                 -- 27
    IntPN = id SS ;
    -- FloatPN  : Float -> PN ;               -- 3.14159
    FloatPN = id SS ;
    -- NumPN    : Card -> PN ;                -- twelve [as proper name]
    NumPN = id SS ;
    -- CNNumNP  : CN -> Card -> NP ;          -- level five ; level 5
    CNNumNP = cc2 ;
    -- CNSymbNP : Det -> CN -> [Symb] -> NP ; -- (the) (2) numbers x and y
    CNSymbNP = cc3 ;

--2 Sentence consisting of a formula

    -- SymbS    : Symb -> S ;                 -- A
    SymbS = id SS ;
--2 Symbols as numerals

    -- SymbNum  : Symb -> Card ;              -- n
    SymbNum = id SS ;
    -- SymbOrd  : Symb -> Ord ;               -- n'th
    SymbOrd = id SS ;
    
--2 Symbol lists

-- A symbol list has at least two elements. The last two are separated
-- by a conjunction ("and" in English), the others by commas.
-- This produces "x, y and z", in English. 

  lincat
    Symb = SS;
    [Symb] = SS;

  lin
    -- MkSymb : String -> Symb ;     -- foo [making a symbol from a string]
    MkSymb = id SS ;

    -- BaseSymb : Symb -> Symb -> ListSymb ;
    BaseSymb = cc2 ;
    -- ConsSymb : Symb -> ListSymb -> ListSynm
    ConsSymb = cc2 ;
    
--2 Obsolescent
    
    -- CNIntNP  : CN -> Int -> NP ;           -- level 53 (covered by CNNumNP)
    CNIntNP = cc2 ;
}
