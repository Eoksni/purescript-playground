module Test.MyMath where

import Prelude
import MyMath (myAdd)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)

spec :: Spec Unit
spec =
  describe "MyMath" do
    describe "myAdd" do
      it "should add 2 to 3" do
        myAdd 2 3 `shouldEqual` 5
