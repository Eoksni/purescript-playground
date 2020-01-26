module Main where

import Prelude
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console (log)
import Effect.Exception (throw)
import Effect.Unsafe (unsafePerformEffect)
import Prim.TypeError (class Warn, Text)
import Unsafe.Coerce (unsafeCoerce)

class NotImplemented a where
  notImplemented :: Warn (Text "NotImplemented") => a

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
  log "hello"
 -- notImplemented -- logShow (notImplemented :: Boolean)
