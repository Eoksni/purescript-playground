module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log, logShow)
import Math (sqrt, pi)

diagonal :: Number -> Number -> Number
diagonal w h = sqrt (w * w + h * h)

circleArea :: Number -> Number
circleArea r = pi * r * r

main :: Effect Unit
main = do
  log "Hello sailor!"
  logShow (diagonal 3.0 4.0)
  logShow (circleArea 5.0)
