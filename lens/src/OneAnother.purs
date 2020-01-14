module OneAnother where

import Prelude
import Data.Either (Either(..))
import Data.Lens (Getter', Prism', _Left, _Right, preview, to)
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

_result :: Getter' OneAnother Int
_result = to getter
  where
  getter w = case w of
    Left _ -> unsafePartial $ fromJust $ preview _one w
    Right _ -> unsafePartial $ fromJust $ preview _another w
