module Test.Main where

import Prelude
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)
import Test.MyMath as MyMath
import Test.Sut as Sut

main :: Effect Unit
main =
  launchAff_
    $ runSpec [ consoleReporter ] do
        Sut.spec
        MyMath.spec
