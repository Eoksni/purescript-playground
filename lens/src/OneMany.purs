module OneMany where

import Prelude
import Control.Alt ((<|>))
import Data.Either (Either(..))
import Data.Lens (Traversal', _Left, _Right, traversed)

type OneMany
  = Either Int (Array Int)

_all1 :: Traversal' OneMany Int
_all1 = _Left

_all2 :: Traversal' OneMany Int
_all2 = _Right <<< traversed
 -- _all :: Traversal' OneMany Int -- _all = to getter --   where --   getter w = case w of --     Left _ ->
