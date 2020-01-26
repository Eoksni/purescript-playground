module SiblingsChildren where

import Prelude
import Control.Apply (lift2)
import Data.Lens (Traversal', traverseOf, traversed, wander)
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Lens.Record (prop)
import Data.Newtype (class Newtype)
import Data.Symbol (SProxy(..))

newtype Node
  = Node
  { slug :: String
  , children :: Array Node
  , siblings :: Array Node
  }

instance showNode :: Show Node where
  show (Node node) = show node

derive instance newtypeNode :: Newtype Node _

_children :: Traversal' Node Node
_children = _Newtype <<< prop (SProxy :: SProxy "children") <<< traversed

_siblings :: Traversal' Node Node
_siblings = _Newtype <<< prop (SProxy :: SProxy "siblings") <<< traversed

_relatives :: Traversal' Node Node
_relatives = wander tra
  where
  tra1 :: forall f. Applicative f => (Node -> f Node) -> Node → f Node
  tra1 = traverseOf _children

  tra2 :: forall f. Applicative f => (Node -> f Node) -> Node → f Node
  tra2 = traverseOf _siblings

  tra :: forall f. Applicative f => (Node -> f Node) -> Node → f Node
  tra g w = lift2 combine fw' fw''
    where
    fw' = tra1 g w

    fw'' = tra2 g w

    -- TODO: how do I get rid of this line???
    combine (Node w') (Node w'') = Node (w' { siblings = w''.siblings })
