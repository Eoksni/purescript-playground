module OneAnother where

import Prelude
import Data.Either (Either(..))
import Data.Lens (Lens', Prism', _Left, _Right, lens, preview, review)
import Data.Maybe (fromJust)
import Partial.Unsafe (unsafePartial)

type OneAnother
  = Either Int Int

exampleOneAnother :: OneAnother
exampleOneAnother = Left 10

_one :: Prism' OneAnother Int
_one = _Left

_another :: Prism' OneAnother Int
_another = _Right

_result :: Lens' OneAnother Int
_result = lens getter setter
  where
  getter :: OneAnother -> Int
  getter x@(Left _) = unsafePartial $ fromJust $ preview _one x

  getter x@(Right _) = unsafePartial $ fromJust $ preview _another x

  setter :: OneAnother -> Int -> OneAnother
  setter (Left _) x = review _one x

  setter (Right _) x = review _another x
