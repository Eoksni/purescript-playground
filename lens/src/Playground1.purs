module Playground1 where

import Prelude
import Data.Lens (Lens', Prism', Traversal, prism', traverseOf, traversed, wander)
import Data.Lens.Record (prop)
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Data.Tuple (Tuple(..))

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

instance showEntry :: Show Entry where
  show (Simple s) = "Simple " <> show s
  show (Complex c) = "Complex " <> show c

_slug :: forall r. Lens' { slug :: Slug | r } Slug
_slug = prop (SProxy :: SProxy "slug")

_active :: forall r. Lens' { active :: Boolean | r } Boolean
_active = prop (SProxy :: SProxy "active")

_children :: Lens' Complex (Array Simple)
_children = prop (SProxy :: SProxy "children")

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

_leafs :: Traversal Entry Entry (Tuple (Maybe Slug) Simple) Simple
_leafs = wander tra
  where
  tra :: forall f. Applicative f => (Tuple (Maybe Slug) Simple -> f Simple) -> Entry -> f Entry
  tra g (Simple w) = Simple <$> g (Tuple Nothing w)

  tra g (Complex w) = Complex <$> traverseOf (_children <<< traversed) (g <<< Tuple (Just w.slug)) w

-- or use Monoid
maybeAppendSlug :: Maybe Slug -> Slug -> Slug
maybeAppendSlug Nothing s' = s'

maybeAppendSlug (Just s) s' = s <> "/" <> s'

absolutifySlug :: Tuple (Maybe Slug) Simple -> Tuple Slug Simple
absolutifySlug (Tuple m s) = Tuple (maybeAppendSlug m s.slug) s

-- to get a list of leafs
-- toListOf (traversed <<< _leafs) exampleEntries
--
-- to update active of all leafs
-- over (traversed <<< _leafs) (\ (Tuple ms s) -> s { active = false }) exampleEntries
exampleSimple1 :: Simple
exampleSimple1 = { slug: "some-simple1", active: true }

exampleSimple2 :: Simple
exampleSimple2 = { slug: "some-simple2", active: false }

exampleSimple3 :: Simple
exampleSimple3 = { slug: "some-simple3", active: false }

exampleComplex1 :: Complex
exampleComplex1 = { slug: "some-complex1", active: true, children: [ exampleSimple1 ] }

exampleComplex2 :: Complex
exampleComplex2 = { slug: "some-complex2", active: false, children: [ exampleSimple2, exampleSimple2 ] }

exampleEntries :: Array Entry
exampleEntries = [ Simple exampleSimple1, Complex exampleComplex1, Complex exampleComplex2 ]
