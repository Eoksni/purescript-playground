module Test.Sut where

import Prelude
import Sut (hello)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec =
  describe "Sut" do
    describe "hello" do
      it "should equal to \"world\"" do
        hello `shouldEqual` "world"
