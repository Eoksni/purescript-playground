module Main where

import Prelude

import Counter (counter)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  container <- getElementById "main" =<< (map toNonElementParentNode $ document =<< window)
  case container of
    Nothing -> throw "Main element not found."
    Just c  ->
      let app = counter { label: "Increment" }
       in render app c
