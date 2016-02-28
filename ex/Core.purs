
module Core where

import Control.Monad.Eff (Eff ())
import Prelude (Unit (), unit, bind, return)
import UiFi.El as El
import UiFi.HTML (div, text, p)
import UiFi.Selector as Selector

foreign import data TEST :: !
foreign import print :: forall a e . a -> Eff (test :: TEST | e) Unit

main :: Eff (dom :: El.DOM) Unit
main = do
  El.place
    (Selector.ofId "container")
    (El.ofNode (div [text "hi", p [text "hello"]]))
  return unit
