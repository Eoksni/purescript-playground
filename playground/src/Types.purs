module Types where

import Prelude
import Control.Monad.Except (runExcept)
import Data.Either (isRight)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Foreign (F, Foreign, ForeignError(..), fail)
import Foreign.Generic (class Decode, class Encode, decode, defaultOptions, encode, genericDecode, genericEncode)
import Type.Proxy (Proxy(..))

data ConfigValueType
  = ConfigValueInt
  | ConfigValueString

derive instance genericConfigValueType :: Generic ConfigValueType _

derive instance eqConfigValueType :: Eq ConfigValueType

instance encodeConfigValueType :: Encode ConfigValueType where
  encode = genericEncode defaultOptions

instance decodeConfigValueType :: Decode ConfigValueType where
  decode = genericDecode defaultOptions

instance showConfigValueType :: Show ConfigValueType where
  show = genericShow

class ReifiesByConfigValueType a where
  reifyByConfigValueType :: Proxy a -> ConfigValueType

instance reifiesByConfigValueTypeInt :: ReifiesByConfigValueType Int where
  reifyByConfigValueType _ = ConfigValueInt

data Reference a
  = Literal a
  | Reference String

instance encodeReference :: (ReifiesByConfigValueType a, Encode a) => Encode (Reference a) where
  encode = encode <<< toReference'

instance decodeReference :: (ReifiesByConfigValueType a, Decode a) => Decode (Reference a) where
  decode = fromReference' <=< decode

data Reference'
  = Literal' Foreign
  | Reference' ConfigValueType String

derive instance genericReference' :: Generic Reference' _

instance encodeReference' :: Encode Reference' where
  encode = genericEncode defaultOptions

instance decodeReference' :: Decode Reference' where
  decode = genericDecode defaultOptions

toReference' :: forall a. Encode a => ReifiesByConfigValueType a => Reference a -> Reference'
toReference' (Literal a) = Literal' (encode a)

toReference' (Reference reference) = Reference' (reifyByConfigValueType (Proxy :: Proxy a)) reference

fromReference' :: forall a. Decode a => ReifiesByConfigValueType a => Reference' -> F (Reference a)
fromReference' (Literal' a) = Literal <$> decode a

fromReference' (Reference' configValueType reference) =
  if (configValueType == expectedConfigValueType) then
    pure (Reference reference)
  else
    fail (ForeignError $ "Expected configValueType: `" <> show expectedConfigValueType <> "`, but got: `" <> show configValueType <> "`")
  where
  expectedConfigValueType = reifyByConfigValueType (Proxy :: Proxy a)

confirm :: ConfigValueType -> Foreign -> Boolean
confirm configValueType f = case configValueType of
  ConfigValueInt -> isRight $ runExcept (decode f :: F Int)
  ConfigValueString -> isRight $ runExcept (decode f :: F String)

myDecode :: forall a. Decode a => ReifiesByConfigValueType a => Foreign -> F (Reference a)
myDecode = decode
