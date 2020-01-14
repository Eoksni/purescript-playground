module Main where

import Prelude
import Data.Array.NonEmpty (NonEmptyArray, cons')
import Data.Array.NonEmpty as NonEmptyArray
import Data.Lens (Lens, Lens', Prism', Traversal', is, lens, only, over, preview, set, toListOf, traversed, view)
import Data.Maybe (isJust)
import Data.String as String
import Data.Tuple (Tuple(..), fst)
import Effect (Effect)
import Effect.Console (log, logShow)

type Activatable
  = { active :: Boolean
    , slug :: String
    }

type SomeRecord
  = { subject :: String
    , object :: String
    , action :: String
    }

_first :: forall a b c. Lens (Tuple a c) (Tuple b c) a b
_first = lens getter setter
  where
  getter = fst

  setter (Tuple _ kept) new = Tuple new kept

_action :: Lens SomeRecord SomeRecord String String
_action = lens getter setter
  where
  getter = _.action

  setter whole new = whole { action = new }

_action' :: Lens' SomeRecord String
_action' = lens _.action $ _ { action = _ }

_head :: forall a. Lens' (NonEmptyArray a) a
_head = lens getter setter
  where
  getter = NonEmptyArray.head

  setter whole new = NonEmptyArray.cons' new (NonEmptyArray.tail whole)

-- TODO: I don't want to be able to change it, only to view it
_slug :: Lens' Activatable String
_slug = lens _.slug $ _ { slug = _ }

_active :: Lens' Activatable Boolean
_active = lens _.active $ _ { active = _ }

_true :: Prism' Boolean Unit
_true = only true

_active_true :: Traversal' Activatable Unit
_active_true = _active <<< _true

_any_active_true :: Traversal' (NonEmptyArray Activatable) Unit
_any_active_true = traversed <<< _active_true

-- _activeAt :: forall r f. Functor f => Lens' (f (WithActive r)) Boolean
-- _activeF = lens getter setter
--   where
--   getter = find
main :: Effect Unit
main = do
  log $ view _first $ Tuple "one" 1
  logShow $ set _first "hello" $ Tuple 1 1
  logShow $ over _first String.length $ Tuple "hi" 123
  logShow $ over _action String.toUpper someRecord
  logShow $ set _action "great action!" someRecord
  logShow $ set _head 123 $ NonEmptyArray.cons' 10 [ 12, 14 ]
  logShow $ set _active true { active: false, slug: "hello world" }
  log "\n  _true:"
  logShow $ view _true true
  logShow $ preview _true true
  logShow $ toListOf _true true
  logShow $ toListOf _true false
  logShow $ (is _true true :: Boolean)
  log "\n  _active_true:"
  logShow $ isJust $ preview _active_true activatable1
  logShow $ isJust $ preview _active_true activatable2
  log "\n _any_active_true:"
  logShow $ isJust $ preview _any_active_true activatables
  where
  activatable1 :: Activatable
  activatable1 = { slug: "first", active: false }

  activatable2 :: Activatable
  activatable2 = { slug: "second", active: true }

  activatables :: NonEmptyArray Activatable
  activatables = cons' activatable1 [ activatable2 ]

  someRecord =
    { subject: "some subject"
    , object: "some object"
    , action: "some action"
    }
