module Test.MyMath where

import Prelude
import MyMath (myAdd)
import Test.QuickCheck ((==?))
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.QuickCheck (quickCheck)

spec :: Spec Unit
spec =
  describe "MyMath" do
    describe "myAdd" do
      it "should add 2 to 3" do
        myAdd 2 3 `shouldEqual` 5
      it "should be commutative" do
        quickCheck \a b -> myAdd a b ==? myAdd b a
