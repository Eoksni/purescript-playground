module FileOperations where

import Data.Array (head, concatMap, (:))
import Data.Foldable (foldr)
import Data.Maybe (Maybe(..), maybe)
import Data.Path (Path, isDirectory, ls, size, filename)
import Prelude (bind, (>), (<), (<<<), (<>), (==), ($))
import Control.Monad (pure)

allFiles :: Path -> Array Path
allFiles file = file : concatMap allFiles (ls file)

allFiles' :: Path -> Array Path
allFiles' file = file : do
  child <- ls file
  allFiles' child

onlyFiles :: Path -> Array Path
onlyFiles fileOrDir =
  if isDirectory fileOrDir
  then concatMap onlyFiles (ls fileOrDir)
  else [fileOrDir]

largestFile :: Path -> Maybe Path
largestFile = foldr f Nothing <<< onlyFiles where
  f :: Path -> Maybe Path -> Maybe Path
  f file1 Nothing = Just file1
  f file1 mfile2@(Just file2) = case msize1, msize2 of
    Nothing, Nothing -> Nothing
    Nothing, _ -> mfile2
    _, Nothing -> mfile1
    Just size1, Just size2 -> if size1 > size2 then mfile1 else mfile2
    where
      mfile1 = Just file1
      msize1 = size file1
      msize2 = size file2

smallestFile :: Path -> Maybe Path
smallestFile = foldr f Nothing <<< onlyFiles where
  f :: Path -> Maybe Path -> Maybe Path
  f file1 Nothing = Just file1
  f file1 mfile2@(Just file2) = case msize1, msize2 of
    Nothing, Nothing -> Nothing
    Nothing, _ -> mfile2
    _, Nothing -> mfile1
    Just size1, Just size2 -> if size1 < size2 then mfile1 else mfile2
    where
      mfile1 = Just file1
      msize1 = size file1
      msize2 = size file2

whereIs :: String -> Path -> Maybe Path
whereIs fname path = head $ do
  file <- ls path
  (if filename file == fname then [path] else []) <> maybe [] pure (whereIs fname file)
