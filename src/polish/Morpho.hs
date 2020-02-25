module Morpho where

import Data.List
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Data.Map as M
import Paradigms(Case(..))

type Form = T.Text
type Lemma = T.Text

-- "ablatyw ablatywie subst:sg:loc.voc:m3"
morphoLine :: T.Text -> (Lemma, M.Map Case Form)
morphoLine line = (lem, M.fromList [(cas, form) | cas <- cases])
  where
    (lem:form:tags:_) = T.words line
    (_:onlynums:onlycases:gender:_) = T.split (==':') tags
    cases = [ readCase num cas 
            | cas <- T.split (=='.') onlycases
            , num <- T.split (=='.') onlynums ]

morphoFile :: T.Text -> M.Map Lemma (M.Map Case Form)
morphoFile file = M.fromListWith M.union $
                    map morphoLine (T.lines file)

readCase :: T.Text -> T.Text -> Case
readCase num cas = case (T.unpack num, T.unpack cas) of
    ("sg", "nom") -> Sg_Nom
    ("sg", "gen") -> Sg_Gen
    ("sg", "dat") -> Sg_Dat
    ("sg", "acc") -> Sg_Acc
    ("sg", "loc") -> Sg_Loc
    ("sg", "inst") -> Sg_Ins
    ("sg", "voc") -> Sg_Voc
    ("pl", "nom") -> Pl_Nom
    ("pl", "gen") -> Pl_Gen
    ("pl", "dat") -> Pl_Dat
    ("pl", "acc") -> Pl_Acc
    ("pl", "loc") -> Pl_Loc
    ("pl", "inst") -> Pl_Ins
    ("pl", "voc") -> Pl_Voc
    x -> error $ "Undefined case: " ++ show x

main :: IO ()
main = do
    file <- T.readFile "morpho.txt"
    mapM_ print (morphoFile file)