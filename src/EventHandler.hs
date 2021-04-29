module EventHandler where

import Models
import GameBoard
import Graphics.Gloss.Interface.Pure.Game

import GameBoard
import Util

getCol :: Char -> Int
getCol 'd' = 0
getCol 'f' = 1
getCol 'j' = 2
getCol 'k' = 3
getCol _   = -1

handleKeys :: Event -> ManiaGame -> ManiaGame

handleKeys (EventKey (SpecialKey KeyDown) Down _ _  ) game@ Game { gameState = MapSelector } =
    game { firstMapHeight = (firstMapHeight game) + 110}

handleKeys (EventKey (SpecialKey KeyUp) Down _ _  ) game@ Game { gameState = MapSelector } =
    game { firstMapHeight = (firstMapHeight game) - 110}

handleKeys (EventKey (Char c) Down _ _) game@ Game { gameState = Playing } =
    hitNoteLogic (getCol c) game

handleKeys _ game = game

nextNote :: Int -> [(Int, Int, Bool, Int)] -> Int
nextNote col [] = -1000
nextNote col (x:xs)
    | col == (snd' x) = fst' x
    | otherwise = nextNote col xs

getNextNote :: ManiaGame -> Int -> Int
getNextNote game col = nextNote col (rawNotes game)

removeItem :: [(Int, Int, Bool, Int)] -> Int -> [(Int, Int, Bool, Int)]
removeItem [] _ = []
removeItem (x:xs) col
    | snd' x == col = xs
    | otherwise = x:(removeItem xs col)

removeNote :: Int -> ManiaGame -> ManiaGame
removeNote col game = game { rawNotes = (removeItem (rawNotes game) col) }

updateCombo :: Int -> ManiaGame -> ManiaGame
updateCombo hitError game = game {combo = newCombo}
    where newCombo = if hitError <= 250 then (combo game) + 1 else 0

updateScore :: Int -> ManiaGame -> ManiaGame
updateScore hitError game = game {score = (score game) + noteScore * ((combo game) + 1)}
    where
        noteScore
            | hitError <= 100 = 300
            | hitError <= 200 = 200
            | hitError <= 250 = 100
            | otherwise = 0

hitNoteLogic :: Int -> ManiaGame -> ManiaGame
hitNoteLogic (-1) game = game
hitNoteLogic col game = removeNote col $ updateCombo hitError $ updateScore hitError game
    where
        nxtNote = getNextNote game col
        hitError = abs (nxtNote - hitOffset)


{-
handleKeys (EventKey (Char c) Down _ _) game@ Game { gameState = Playing } =
    game { buttons = updateValue (buttons game) True (getCol c) }

handleKeys (EventKey (Char c) Up _ _) game@ Game { gameState = Playing } =
    game { buttons = updateValue (buttons game) False (getCol c) }

handleKeys (EventKey (Char c) Down _ _) game@ Game { gameState = Playing } =
    game { buttons = updateValue (buttons game) True (getCol c) }

hitNoteLogic :: ManiaGame -> ManiaGame
hitNoteLogic = modify (isActive 0) doD
    where
        doD game
            | nxtNote == -1000 = game
            | otherwise = (removeNote 0 nxtNote
                           (if hitError <= 100
                            then game { score = (score game) + 10 }
                            else game)) { buttons = updateValue (buttons game) False 0 }
            where
                nxtNote = getNextNote game 0
                hitError = abs (nxtNote - hitOffset)

modify :: (ManiaGame -> Bool) -> (ManiaGame -> ManiaGame) -> ManiaGame -> ManiaGame
modify pred mod game = if pred game then mod game else game

keyD :: ManiaGame -> Bool
keyD game = (buttons game) !! 0

isActive :: Int -> ManiaGame -> Bool
isActive col game = (buttons game) !! col

-}

