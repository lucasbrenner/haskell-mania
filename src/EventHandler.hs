module EventHandler where

import Graphics.Gloss.Interface.Pure.Game

import GameBoard
import Util

getCol :: Char -> Int
getCol 'd' = 0
getCol 'f' = 1
getCol 'j' = 2
getCol 'k' = 3

handleKeys :: Event -> ManiaGame -> ManiaGame

handleKeys (EventKey (Char c) Down _ _) game@ Game { gameState = Playing } =
    game { buttons = updateValue (buttons game) True (getCol c) }

handleKeys (EventKey (Char c) Up _ _) game@ Game { gameState = Playing } =
    game { buttons = updateValue (buttons game) False (getCol c) }

handleKeys _ game = game

modify :: (ManiaGame -> Bool) -> (ManiaGame -> ManiaGame) -> ManiaGame -> ManiaGame
modify pred mod game = if pred game then mod game else game

keyD :: ManiaGame -> Bool
keyD game = (buttons game) !! 0

isActive :: Int -> ManiaGame -> Bool
isActive col game = (buttons game) !! col

nextNote :: Int -> [(Int, Int, Bool, Int)] -> Int
nextNote col [] = -1000
nextNote col (x:xs)
    | col == (snd' x) = fst' x
    | otherwise = nextNote col xs

getNextNote :: ManiaGame -> Int -> Int
getNextNote game col = nextNote col (rawNotes game)

removeItem :: [(Int, Int, Bool, Int)] -> Int -> Int -> [(Int, Int, Bool, Int)]
removeItem (x:xs) col value
    | fst' x == value && snd' x == col = xs
    | otherwise = x:(removeItem xs col value)

removeNote :: Int -> Int -> ManiaGame -> ManiaGame
removeNote col coord game = game { rawNotes = (removeItem (rawNotes game) col coord) }

hitNoteLogic :: ManiaGame -> ManiaGame
hitNoteLogic = modify (isActive 0) doD
    where
        doD game
            | nxtNote == -1000 = game
            | otherwise = (removeNote 0 nxtNote
                           (if abs nxtNote <= 100
                            then game { score = (score game) + 10 }
                            else game)) { buttons = updateValue (buttons game) False 0 }
            where
                nxtNote = getNextNote game 0
