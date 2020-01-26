module Main where

import Prelude
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Exception (throw)
import Effect.Unsafe (unsafePerformEffect)
import Unsafe.Coerce (unsafeCoerce)

class NotImplemented a where
  notImplemented :: a

instance notImplementedEffect :: NotImplemented (Effect a) where
  notImplemented = throw notImplemented
else instance notImplementedMonadEffect :: MonadEffect m => NotImplemented (m a) where
  notImplemented = liftEffect notImplemented
else instance notImplementedFunction :: NotImplemented (a -> b) where
  notImplemented _ = unsafePerformEffect notImplemented
else instance notImplementedAny :: NotImplemented a where
  notImplemented = unsafeCoerce "notImplemented"

-- hello :: Boolean -> String
-- hello = notImplemented
main :: Effect Unit
main = do
  notImplemented
 -- logShow (notImplemented :: Boolean)
