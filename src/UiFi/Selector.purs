
module UiFi.Selector where

import Prelude ((++))

-- | A selector for page elements
newtype Selector = Selector String

-- | View a string representation of the `Selector`
toString :: Selector -> String
toString (Selector s) = s

-- | Construct a `Selector` for a given element ID
ofId :: String -> Selector
ofId s = Selector ("#" ++ s)
