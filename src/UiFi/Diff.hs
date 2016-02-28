
module UiFi.Diff where

import UiFi.Node.Zipper (Zipper (Zipper))

data Diff
  = DRemove
  | DInsert Node
  | DReplaceText String
  | DReorder
