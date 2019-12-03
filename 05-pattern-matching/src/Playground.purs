module Playground where

import Prelude hiding (gcd)

gcd :: Int -> Int -> Int
gcd n 0 = n
gcd 0 m = m
gcd n m
  | n > m = gcd (n - m) m
  | otherwise = gcd n (m - n)

fromString :: String -> Boolean
fromString "true" = true
fromString _ = false

toString :: Boolean -> String
toString true = "true"
toString false = "false"

fact :: Int -> Int
fact 0 = 1
fact n = n * fact (n - 1)

isEmpty :: forall a. Array a -> Boolean
isEmpty [] = true
isEmpty _ = false

showPerson :: forall r.
  { first :: String
  , last :: String
  | r
  }
  -> String
showPerson { first, last } = last <> ", " <> first

type Address = { street :: String, city :: String }

type Person = { name :: String, address :: Address }

livesInLA :: Person -> Boolean
livesInLA { address: { city: "Los Angeles" } } = true
livesInLA _ = false

sortPair :: Array Int -> Array Int
sortPair arr@[x, y]
  | x <= y = arr
  | otherwise = [y, x]
sortPair arr = arr

sameCity :: Person -> Person -> Boolean
sameCity
  {
    address: {
      city: city1
    }
  }
  {
    address: {
      city: city2
    }
  }
  = city1 == city2
