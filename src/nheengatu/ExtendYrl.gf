--1 Extensions of core RGL syntax (the Grammar module)

-- This module defines syntax rules that are not yet implemented in all
-- languages, and perhaps never implementable either. But all rules are given
-- a default implementation in common/ExtendFunctor.gf so that they can be included
-- in the library API. The default implementations are meant to be overridden in each
-- xxxxx/ExtendXxx.gf when the work proceeds.
--
-- This module is aimed to replace the original Extra.gf, which is kept alive just
-- for backwardcommon compatibility. It will also replace translator/Extensions.gf
-- and thus eliminate the often duplicated work in those two modules.
--
-- (c) Aarne Ranta 2017-08-20 under LGPL and BSD


concrete ExtendYrl of Extend = CatYrl ** open Prelude, ResYrl, (N=NounYrl) in {

  lin

    -- GenModNP    : Num -> NP -> CN -> NP ; -- this man's car(s)
    GenModNP num np cn =
      let cn : CN = N.PossNP cn np
       in N.DetCN (N.DetQuant N.IndefArt num) cn ;

    -- UseComp_estar : Comp -> VP ; -- (Cat, Spa, Por) "está cheio" instead of "é cheio"
    UseComp_estar comp = {
      s = \\agr =>
        YrlCopula agr Stage comp.c comp.v (comp.s ! ag2psor agr)  ;
      l = Stage ;
      } ;

}
