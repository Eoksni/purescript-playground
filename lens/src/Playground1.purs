module Playground1 where

import Prelude
import Data.Lens (Lens', Prism', Traversal', prism', traversed)
import Data.Lens.Fold (traverseOf_)
import Data.Lens.Record (prop)
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Effect (Effect)
import Effect.Console (logShow)

type Slug
  = String

type Simple
  = { slug :: Slug
    , active :: Boolean
    }

type Complex
  = { slug :: Slug
    , active :: Boolean
    , children :: Array Simple
    }

data Entry
  = Simple Simple
  | Complex Complex

_slug :: forall r. Lens' { slug :: Slug | r } Slug
_slug = prop (SProxy :: SProxy "slug")

_active :: forall r. Lens' { active :: Boolean | r } Boolean
_active = prop (SProxy :: SProxy "active")

_children :: Lens' Complex (Array Simple)
_children = prop (SProxy :: SProxy "children")

_child :: Traversal' Complex Simple
_child = _children <<< traversed

_Simple :: Prism' Entry Simple
_Simple =
  prism' Simple case _ of
    Simple simple -> Just simple
    _ -> Nothing

_Complex :: Prism' Entry Complex
_Complex =
  prism' Complex case _ of
    Complex complex -> Just complex
    _ -> Nothing

handleEntry :: Entry -> Effect Unit
handleEntry entry = do
  traverseOf_ _Simple logShow entry
  traverseOf_ (_Complex <<< _child) logShow entry
