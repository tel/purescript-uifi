
module UiFi.HTML where

import Data.List as List
import Data.Maybe (Maybe (Nothing))
import UiFi.Node (Node (Text, Node))

text :: String -> Node
text = Text

node :: String -> Array Node -> Node
node tag children = 
  Node { tag, key: Nothing } (List.fromFoldable children)

p :: Array Node -> Node
p = node "p"

div :: Array Node -> Node
div = node "div"
