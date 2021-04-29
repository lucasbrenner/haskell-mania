module Util where

import Graphics.Gloss
import System.IO.Unsafe (unsafeDupablePerformIO)

import Models

fst' (a, _, _, _) = a
snd' (_, a, _, _) = a
trd (_, _, a, _) = a
frth (_, _, _, a) = a

coolCyan :: Color
coolCyan = makeColorI 53 200 254 255

{-|
    Updates the index 'idx' of a list to 'value'.
-}
updateValue :: [a] -> a -> Int -> [a]
updateValue list value idx
    | idx == 0 = value:(tail list)
    | otherwise = (head list):(updateValue (tail list) value (idx - 1))

type StartTime = Int
type Column = Int
type IsSlide = Bool
type EndTime = Int

mapDir :: String
mapDir = "assets/maps/"

{-|
    Retorna uma lista de strings, onde cada string corresponde a uma linha
    do arquivo lido.
-}
getFileLines :: String -> [String]
getFileLines path = do
    let file = unsafeDupablePerformIO (readFile path)
    lines file

{-
    Recebe uma lista das linhas de um arquivo .hmania só com as linhas das notas
    e retorna uma lista com as tuplas das notas.
-}
getRawNotes :: [String] -> [(StartTime, Column, IsSlide, EndTime)]
getRawNotes lines = 
    [(read (line !! 0) :: Int
    , read (line !! 1) :: Int
    , read (line !! 2) :: Bool
    , read (line !! 3) :: Int)
    | line <- map (split ' ') lines
    ]
{-
    Recebe o nome do arquivo de um mapa e retorna a estrutura ManiaMap com
    esse mapa.
-}
loadMap :: String -> ManiaMap
loadMap map_file = ManiaMap
    { title = lines !! 0
    , artist = lines !! 1
    , difficulty = lines !! 2
    , mapRawNotes = getRawNotes (drop 3 lines)
    }
    where
        lines = getFileLines $ mapDir ++ map_file

{-|
    Retorna uma lista de strings a partir de uma string, utilizando um
    caractere como delimitador.
-}
split :: Eq a => a -> [a] -> [[a]]
split d [] = []
split d s = x : split d (drop 1 y) where (x,y) = span (/= d) s
