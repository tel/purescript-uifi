
module UiFi.Node where

import Data.Maybe (Maybe (Just))
import Data.List (List ())

type NodeData = 
  { tag :: String
  , key :: Maybe String 
  }

data Node
  = Text String
  | Node NodeData (List Node)

-- | Update a `Node` to use a key value
key :: String -> Node -> Node
key k n@(Text _) = n
key k n@(Node dat c) = Node (dat { key = Just k }) c

