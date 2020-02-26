module Main where

import Control.Monad
import Data.List
import qualified Data.Map as M
import qualified Data.Set as S
import qualified Data.Text    as T
import qualified Data.Text.IO as T
import qualified Paradigms as P
import Paradigms (Case(..))


-- data Case = Sg_Nom | Sg_Gen | … defined in Paradigms
type Paradigm = T.Text
type Form = T.Text
type ParadigmMap = M.Map Paradigm (M.Map Case Form)
type Case_Form = (Case, Form)
type CF_Combination = [Case_Form]


paradigm_map :: ParadigmMap
paradigm_map = M.fromList [(T.pack paradigm, M.fromList cases_forms)
                          | (paradigm, cases_forms) <- P.paradigms
                          ]

allomorphs_per_case :: ParadigmMap -> Case -> M.Map Form Int
allomorphs_per_case paramap cas =
  M.fromListWith (+)
    [ (frm, 1)
    | (cse,frm) <- all_cases_forms paramap
    , cse == cas ]


all_cases_forms = all_cases_forms' (enumFromTo Sg_Nom Pl_Voc)

all_cases_forms' :: [Case] -> ParadigmMap -> CF_Combination
all_cases_forms' cases paramap = S.toList $ S.fromList $
  [ (cse,frm)
  | cases_forms <- M.elems paramap 
  , (cse,frm) <- M.assocs cases_forms
  , '[' `notElem` T.unpack frm
  , cse  `elem` cases
  ] :: [(Case, Form)]


cf_combos :: ParadigmMap -> [Case] -> [CF_Combination]
cf_combos paramap cases = sequence cases_forms
  where
    fstEq = \(a,_) (a',_) -> a==a'
    cases_forms = groupBy fstEq (all_cases_forms' cases paramap)

best_combo :: ParadigmMap -> [[Case]] -> [Case]
best_combo paramap casecombos = fst $ maximumBy max' cfs_paradigms
  where
    max' :: ([Case], M.Map CF_Combination [Paradigm]) -> ([Case], M.Map CF_Combination [Paradigm]) -> Ordering
    max' (_, a) (_, b) = M.size a `compare` M.size b

    -- For each [(case, "form")] e.g. [(Sg_Gen,"i"),(Sg_Nom,"a")] keep a list of 
    -- paradigms in which those cases have those forms.
    cfs_paradigms  = 
      [(cases3, M.fromListWith (++)
            [ (case_form, M.keys $ filterParamap paramap case_form)
            | case_form <- cfs
            ])
      | cases3 <- casecombos
      , let cfs = cf_combos paramap cases3
      ] :: [([Case], M.Map CF_Combination [Paradigm])]

-- Return those paradigms that have a combination of given [case,form]
-- e.g. Sg_Nom="a", Sg_Gen="i"
filterParamap :: ParadigmMap -> CF_Combination -> ParadigmMap
filterParamap paramap cases_forms =
  M.fromList
    [ (paradigm, cf_map)
    | (paradigm, cf_map) <- M.assocs paramap
    , all (`elem` M.assocs cf_map) cases_forms
    ]

main :: IO ()
main = do

  let all_cases = enumFromTo Sg_Gen Pl_Voc
  let cases3 = [ cases 
                      | cases <- subsequences all_cases 
                      , length cases == 4 ] :: [[Case]]

  let bestCombo = best_combo paradigm_map cases3 :: [Case]
  print bestCombo 

  let cfs_paradigms = 
        M.fromListWith M.union
              [ (case_form, filterParamap paradigm_map case_form)
              | case_form <- cf_combos paradigm_map bestCombo
              ] :: M.Map CF_Combination ParadigmMap

  let foo = [ (cf, count, M.keys paras)
            | (cf, paras) <- M.assocs cfs_paradigms
            , let count = M.size paras
            , count > 0
            ]

  mapM_ (\(cf, count, paras) -> 
          do T.putStr (T.pack $ show cf)
             putStr (" ")
             putStrLn (show count)
             mapM_ (\x -> putStrLn ("\t" ++ show x)) paras
        ) (sortBy (\(a,b,c) (a',b',c') -> (flip compare) b b') foo)


  -- let formCount = 
  --       M.fromList [ (cf, 
  --                     M.fromList [ (cas, 
  --                                     M.unions [ allomorphs_per_case paramap cas
  --                                              | paramap <- paramaps]
  --                                   )
  --                                 | cas <- cases ]
  --                     )
  --                   | (cf, paramaps) <- M.assocs cfs_paradigm 
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

