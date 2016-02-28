module Test.Main where

import Prelude (Unit)
import Control.Monad.Eff (Eff)

import Test.Unit (test, runTest, TIMER)
import Test.Unit.Console (TESTOUTPUT)
import Control.Monad.Aff.AVar (AVAR)
import Test.Unit.Assert as Assert

main :: forall e . Eff (timer :: TIMER, avar :: AVAR, testOutput :: TESTOUTPUT | e) Unit
main = runTest do
  test "system" do
    Assert.assert "test system is totally broken" true
