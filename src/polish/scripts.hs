module Main where

import Data.List
import qualified Data.Map as M
import Paradigms (Case(..))
import qualified Paradigms as P
import Control.Monad

import qualified Data.Text    as T
import qualified Data.Text.IO as TIO

-- data Case = Sg_Nom | Sg_Gen | … defined in Paradigms
type Paradigm = T.Text
type Form = T.Text
type ParadigmMap = M.Map Paradigm (M.Map Case Form)
type Case_Form = (Case, Form)


paradigm_map :: ParadigmMap
paradigm_map = M.fromList [(T.pack paradigm, M.fromList cases_forms)
                          | (paradigm, cases_forms) <- P.paradigms
                          ]


allomorphs_per_case :: ParadigmMap -> Case -> M.Map Form Int
allomorphs_per_case paramap cas =
  M.fromListWith (+)
    [ (frm, 1)
    | (cse,frm) <- all_cases_forms paramap
    , cse == cas
    , '[' `notElem` T.unpack frm ]

all_cases_forms :: ParadigmMap -> [(Case, Form)]
all_cases_forms paramap = concat $ M.assocs `map` M.elems paramap :: [(Case, Form)]

-- Return those paradigms that have a combination of given  [case,form]
-- e.g. Sg_Nom="a", Sg_Gen="i"
combinations :: ParadigmMap -> [(Case, Form)] -> ParadigmMap
combinations paramap cases_forms =
  M.fromList
    [ (paradigm, cf_map)
    | (paradigm, cf_map) <- M.assocs paramap
    , all (`elem` M.assocs cf_map) cases_forms
    ]


main :: IO ()
main = do
  let cases = enumFromTo Sg_Nom Pl_Voc

  -- For each (case, "form") e.g. (Sg_Gen,"i"), keep a list of paradigms
  -- where that case has that form.
  let cfs_paramaps = M.fromListWith (++)
          [ (case_form, [combinations paradigm_map [case_form]])
          | case_form <- all_cases_forms paradigm_map
          , fst case_form `elem` enumFromTo Sg_Nom Sg_Voc
          , ']' `notElem` (T.unpack $ snd case_form)
          ] :: M.Map Case_Form [ParadigmMap]


  let foo = -- M.fromListWith (+) 
        [ ((cas,form), length paramaps) 
        | ((cas,form), paramaps) <- M.assocs cfs_paramaps
        ]

  mapM_ (\(cf, count) -> 
          do TIO.putStr (T.pack $ show cf)
             putStr (" ")
             putStrLn (show count)
        ) (sort foo) --(sortBy sndBigger $  foo)

  
  -- (Sg_Gen,"i") |--->  {Case |---> {"form" |--> count}}
  -- let formCount = 
  --       M.fromList [ (cf, 
  --                     M.fromList [ (cas, 
  --                                     M.unions [ allomorphs_per_case paramap cas
  --                                              | paramap <- paramaps]
  --                                   )
  --                                 | cas <- cases ]
  --                     )
  --                   | (cf, paramaps) <- M.assocs cfs_paramaps
  --                   ] :: M.Map Case_Form (M.Map Case (M.Map Form Int))

  -- M.assocs formCount `forM_` (\(cf, cases_forms) ->
  --                 do putStrLn ""
  --                    print cf
  --                    putStrLn "----------------"
  --                    M.assocs cases_forms `forM_` (\(cas,mp) -> do
  --                            putStrLn ""
  --                            print cas
  --                            let forms_counts = sortBy sndBigger (M.assocs mp)
  --                            forM_ forms_counts (\(frm,cnt) -> putStrLn (show frm ++ " " ++ show cnt))
  --                            )
  --                  )

sndBigger :: (Ord b) => (a,b) -> (a,b) -> Ordering
sndBigger = \(_,b) (_,b') -> (flip compare) b b'

