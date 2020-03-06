#!/bin/zsh

echo "module Paradigms where
import qualified Data.Text as T

data Case = Sg_Nom | Sg_Gen | Sg_Dat | Sg_Acc | Sg_Ins | Sg_Loc | Sg_Voc
              | Pl_Nom | Pl_Gen | Pl_Dat | Pl_Acc | Pl_Ins | Pl_Loc | Pl_Voc
      deriving (Show, Eq, Ord, Enum)

paradigms :: [((T.Text, Int), [(Case, T.Text)])]
paradigms = [
"
# First two seds: preparation for irregularities
grep -A16 "oper.*lexem" NounMorphoPol.gf \
| sed 's/    table {//g' | tr -s '\n' \
| sed 's/\[\]/"NO_PLURAL"/g' \
| sed 's/      let x = lexem in/      let x = Predef.tk 0 lexem in/' \
\
| sed -E 's/.* (mkNTable.....?) .*/    \(\(T.pack "\1", /g' \
| sed -E 's/    oper (.*) lexem.*/\1/g' \
| sed -E 's/      let x = Predef.tk (.*) lexem in/                   \1\), [/g' \
| sed -E 's/      SF (..) (...).*(".*");/        (\1_\2, T.pack \3),/g' \
| sed -E 's/      SF (..) (...).*(".*")/        (\1_\2, T.pack \3)]/g' \
| sed 's/\-\-/    ),/g'

echo "    )]"

