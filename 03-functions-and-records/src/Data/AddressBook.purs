module Data.AddressBook where

import Prelude

import Control.Plus (empty)
import Data.List (List(..), filter, head, null, nubBy)
import Data.Maybe (Maybe)

type Address =
  { street :: String
  , city   :: String
  , state  :: String
  }

type Entry =
  { firstName :: String
  , lastName  :: String
  , address   :: Address
  }

type AddressBook = List Entry

showAddress :: Address -> String
showAddress addr = addr.street <> ", " <> addr.city <> ", " <> addr.state

showEntry :: Entry -> String
showEntry entry = entry.lastName <> ", " <> entry.firstName <> ": " <> showAddress entry.address

emptyBook :: AddressBook
emptyBook = empty

insertEntry :: Entry -> AddressBook -> AddressBook
insertEntry = Cons

findEntry :: String -> String -> AddressBook -> Maybe Entry
findEntry firstName lastName = head <<< filter f
  where
    f :: Entry -> Boolean
    f entry = entry.firstName == firstName && entry.lastName == lastName

findEntryByStreetAddress :: String -> AddressBook -> Maybe Entry
findEntryByStreetAddress street = head <<< filter f
  where
    f :: Entry -> Boolean
    f entry = entry.address.street == street

hasFirstName :: String -> AddressBook -> Boolean
hasFirstName firstName = null <<< filter f
  where
    f :: Entry -> Boolean
    f entry = entry.firstName == firstName

removeDuplicates :: AddressBook -> AddressBook
removeDuplicates = nubBy f
  where
    f :: Entry -> Entry -> Boolean
    f entry1 entry2 = entry1.firstName == entry2.firstName && entry1.lastName == entry2.lastName
