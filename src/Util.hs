module Util where

import System.IO.Unsafe (unsafeDupablePerformIO)
import Data.Char

{-|
  Retorna uma lista de strings, onde cada string corresponde a uma linha
  do arquivo lido.
-}
getFileLines :: String -> [String]
getFileLines path = do
  let file = unsafeDupablePerformIO (readFile path)
  lines file


