--1 Numerals

-- This grammar defines numerals from 1 to 999999. 
-- The implementations are adapted from the
-- [numerals library http://www.cs.chalmers.se/~aarne/GF/examples/numerals/] 
-- which defines numerals for 88 languages.
-- The resource grammar implementations add to this inflection (if needed)
-- and ordinal numbers.
--
-- *Note* 1. Number 1 as defined 
-- in the category $Numeral$ here should not be used in the formation of
-- noun phrases, and should therefore be removed. Instead, one should use
-- [Structural Structural.html]$.one_Quant$. This makes the grammar simpler
-- because we can assume that numbers form plural noun phrases.
--
-- *Note* 2. The implementations introduce spaces between
-- parts of a numeral, which is often incorrect - more work on
-- (un)lexing is needed to solve this problem.

concrete NumeralYrl of Numeral = CatYrl [Numeral,Digits] ** open Prelude in {

  lincat 
    Digit = SS ;      -- 2..9
    Sub10 = SS ;      -- 1..9
    Sub100 = SS ;     -- 1..99
    Sub1000 = SS ;    -- 1..999
    Sub1000000 = SS;  -- 1..999999

  lin
    -- num : Sub1000000 -> Numeral ; -- 123456 [coercion to top category]
    num = id SS ;
    
    -- n2, n3, n4, n5, n6, n7, n8, n9 : Digit ;
    n2 = ss "" ;
    n3 = ss "" ;
    n4 = ss "" ;
    n5 = ss "" ;
    n6 = ss "" ;
    n7 = ss "" ;
    n8 = ss "" ;
    n9 = ss "" ;
    
    -- pot01 : Sub10 ;                               -- 1
    pot01 = ss "" ;
    -- pot0 : Digit -> Sub10 ;                       -- d * 1
    pot0 = id SS ;
    -- pot110 : Sub100 ;                             -- 10
    pot110 = ss "" ;
    -- pot111 : Sub100 ;                             -- 11
    pot111 = ss "" ;
    -- pot1to19 : Digit -> Sub100 ;                  -- 10 + d
    pot1to19 = id SS ;
    -- pot0as1 : Sub10 -> Sub100 ;                   -- coercion of 1..9
    pot0as1 = id SS ;
    -- pot1 : Digit -> Sub100 ;                      -- d * 10
    pot1 = id SS ;
    -- pot1plus : Digit -> Sub10 -> Sub100 ;         -- d * 10 + n
    pot1plus = cc2 ;
    -- pot1as2 : Sub100 -> Sub1000 ;                 -- coercion of 1..99
    pot1as2 = id SS ;
    -- pot2 : Sub10 -> Sub1000 ;                     -- m * 100
    pot2 = id SS ;
    -- pot2plus : Sub10 -> Sub100 -> Sub1000 ;       -- m * 100 + n
    pot2plus = cc2 ;
    -- pot2as3 : Sub1000 -> Sub1000000 ;             -- coercion of 1..999
    pot2as3 = id SS ;
    -- pot3 : Sub1000 -> Sub1000000 ;                -- m * 1000
    pot3 = id SS ;
    -- pot3plus : Sub1000 -> Sub1000 -> Sub1000000 ; -- m * 1000 + n
    pot3plus = cc2 ;
    
-- Numerals as sequences of digits have a separate, simpler grammar

  lincat
    Dig = SS;  -- single digit 0..9

  lin
    -- IDig  : Dig -> Digits ;       -- 8
    IDig = id SS ;
    -- IIDig : Dig -> Digits -> Digits ; -- 876
    IIDig = cc2 ;
    
    -- D_0, D_1, D_2, D_3, D_4, D_5, D_6, D_7, D_8, D_9 : Dig ;
    D_0 = ss "" ;
    D_1 = ss "" ;
    D_2 = ss "" ;
    D_3 = ss "" ;
    D_4 = ss "" ;
    D_5 = ss "" ;
    D_6 = ss "" ;
    D_7 = ss "" ;
    D_8 = ss "" ;
    D_9 = ss "" ;
    
}
