
module UiFi.El where

import Control.Monad.Eff (Eff ())
import Data.Function (Fn1 (), runFn1, Fn2 (), runFn2, Fn3 (), runFn3)
import Data.List (List (Nil, Cons))
import Data.List as List
import Data.Maybe (Maybe (Just, Nothing))
import Prelude (Unit (), unit, return, bind)
import UiFi.Node (Node (Text, Node))
import UiFi.Selector (Selector ())
import UiFi.Selector as Selector

-- | Type describing effects involving DOM elements (`El`s) in the page
foreign import data DOM :: !

-- | An full DOM element. This is exposed only abstractly (!) in UiFi so it's
-- | difficult to know what capabilities it might have.
foreign import data El :: *

-- | Recursively construct a live `El`ement value from a `Node` template
ofNode :: Node -> El
ofNode (Text s) = runFn1 makeTextEl s
ofNode (Node dat children) = 
  runFn2 makeNodeEl dat.tag (\f -> consumeList children (\n -> f (ofNode n)))

-- | Use a `Selector` to seek out an `El` in the current document
select :: forall e . Selector -> Eff (dom :: DOM | e) (Maybe El)
select sel = runFn3 select_ Just Nothing (Selector.toString sel)

-- | Use a `Selector` to seek out all matching `El`s in the current document
selectAll :: forall e . Selector -> Eff (dom :: DOM | e) (List El)
selectAll sel = do
  ary <- runFn1 selectAll_ (Selector.toString sel)
  return (List.fromFoldable ary)

-- | Insert an `El` into the document under a `Selector` if the `Selector` 
-- | matches. If it matches and the element is inserted return `true`,
-- | else `false`.
place :: forall e . Selector -> El -> Eff (dom :: DOM | e) Boolean
place sel el = do
  mayEl <- select sel
  case mayEl of
    Nothing -> return false
    Just parent -> do
      runFn3 place_ unit parent el
      return true

-- FFI
-- ----------------------------------------------------------------------------

foreign import makeTextEl 
  :: Fn1 String El

foreign import makeNodeEl 
  :: Fn2 String ((El -> Unit) -> Unit) El

consumeList :: forall a . List a -> (a -> Unit) -> Unit
consumeList Nil f = unit
consumeList (Cons a as) f =
  case f a of
    _unit -> consumeList as f

foreign import select_
  :: forall e . Fn3 (El -> Maybe El) (Maybe El) String (Eff (dom :: DOM | e) (Maybe El))

foreign import selectAll_
  :: forall e . Fn1 String (Eff (dom :: DOM | e) (Array El))

foreign import place_ 
  :: forall e . Fn3 Unit El El (Eff (dom :: DOM | e) Unit)
