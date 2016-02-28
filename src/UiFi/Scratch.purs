module UiFi.Scratch where

import Prelude (Unit (), unit, map, (++), return)
import Data.List (List ())
import Data.List as List
import Data.Maybe (Maybe (Just, Nothing))
import Control.Monad.Eff (Eff ())

foreign import data TEST :: !

foreign import print 
  :: forall a . a -> Eff (test :: TEST) Unit

main :: Eff (dom :: DOM) Unit
main = 
  place 
    (selectId "container") 
    (makeEl (div [txt "hi", p [txt "hello"]]))

-- Node 
-- ----------------------------------------------------------------------------

data Node
  = Text String
  | Node { tag :: String
         , key :: Maybe String
         , children :: List Node
         }

wkey :: String -> Node -> Node
wkey k n@(Text _) = n
wkey k n@(Node s) = Node (s { key = Just k })

-- Diff
-- ----------------------------------------------------------------------------

-- data Diff 
--   = DRemove
--   | DInsert Node
--   | DReplaceText String
--   | DReorder 

-- diffNode :: Diff -> DiffState -> DiffState
-- diffNode d n 
--   case d of
--     DRemove 

-- El
-- ----------------------------------------------------------------------------

foreign import data DOM :: !
foreign import data El :: *
foreign import makeTextEl :: String -> El
foreign import makeNodeEl :: String -> List El -> El
foreign import select_ :: (El -> Maybe El) -> Maybe El -> String -> Maybe El
foreign import place_ :: forall e . El -> El -> Eff (dom :: DOM | e) Unit

-- | TODO: Make this opaque
newtype Selector = Selector String

selectId :: String -> Selector
selectId n = Selector ("#" ++ n)

makeEl :: Node -> El
makeEl (Text s) = makeTextEl s
makeEl (Node x) = makeNodeEl x.tag (map makeEl x.children)

select :: Selector -> Maybe El
select (Selector selector) = select_ Just Nothing selector

place :: forall e . Selector -> El -> Eff (dom :: DOM | e) Unit
place sel el = 
  case select sel of
    Nothing -> return unit
    Just parent -> place_ parent el

-- Helpers
-- ----------------------------------------------------------------------------

txt :: String -> Node
txt = Text

node :: String -> Array Node -> Node
node tag children = 
  Node { tag, children: List.fromFoldable children, key: Nothing }

p :: Array Node -> Node
p = node "p"

div :: Array Node -> Node
div = node "div"
