
module Core where

import Control.Monad.Eff (Eff ())
import Prelude (Unit ())

foreign import data TEST :: !
foreign import print :: forall a e . a -> Eff (test :: TEST | e) Unit

main :: forall e . Eff (test :: TEST | e) Unit
main = print 3
