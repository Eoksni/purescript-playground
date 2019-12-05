module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

import Effect.Unsafe (unsafePerformEffect)

import Counter (counter)

main :: Effect Unit
main = do
  container <- getElementById "main" =<< (map toNonElementParentNode $ document =<< window)
  case container of
    Nothing -> throw "Main element not found."
    Just c  ->
      let app = counter { label: "Increment" }
      in render app c

-- cause of https://github.com/ethul/purs-loader/issues/33
program :: Unit
program = unsafePerformEffect main
