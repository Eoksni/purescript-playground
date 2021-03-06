module Main where

import Prelude
import Reducer (mkReducer)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.Hooks (element)
import React.Basic.DOM (render)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  container <- getElementById "main" =<< (map toNonElementParentNode $ document =<< window)
  case container of
    Nothing -> throw "Container element not found."
    Just c -> do
      reducer <- mkReducer
      let
        app = element reducer {}
      render app c
