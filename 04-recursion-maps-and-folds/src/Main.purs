module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log, logShow)
import Data.Array (filter)

isEven :: Int -> Boolean
isEven 1 = false
isEven x = not $ isEven (x - 1)

infixl 4 filter as <$?>

main :: Effect Unit
main = do
  log "Hello sailor!"
  logShow $ (\x -> x < 3) <$?> [1, 2, 3]
