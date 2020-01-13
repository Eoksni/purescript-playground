module Main where

import Prelude
import Data.Lens (Lens, lens, over, set, view)
import Data.String as String
import Data.Tuple (Tuple(..), fst)
import Effect (Effect)
import Effect.Console (log, logShow)

_first :: forall a b ignored. Lens (Tuple a ignored) (Tuple b ignored) a b
_first = lens getter setter
  where
  getter = fst

  setter (Tuple _ kept) new = Tuple new kept

main :: Effect Unit
main = do
  log $ view _first $ Tuple "one" 1
  logShow $ set _first "hello" $ Tuple 1 1
  logShow $ over _first String.length $ Tuple "hi" 123
