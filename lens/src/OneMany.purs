module OneMany where

import Prelude
import Data.Array.NonEmpty (NonEmptyArray, cons')
import Data.Array.NonEmpty as NonEmptyArray
import Data.Either (Either(..))
import Data.Lens (Lens', Traversal', _Left, _Right, lens, traversed)

type OneMany
  = Either Int (NonEmptyArray Int)

_all1 :: Traversal' OneMany Int
_all1 = _Left

_all2 :: Traversal' OneMany Int
_all2 = _Right <<< traversed

_all_lens :: Lens' OneMany (NonEmptyArray Int)
_all_lens = lens getter setter
  where
  getter (Left a) = cons' a []

  getter (Right as) = as

  setter (Left _) as = Left (NonEmptyArray.head as) -- lens law is broken! get after set is not id

  setter (Right _) as = Right as

_all :: Traversal' OneMany Int
_all = _all_lens <<< traversed
