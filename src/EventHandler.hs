module EventHandler where

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

handleKeys (EventKey (Char c) Down _ _) game@ Game { gameState = Playing } =
    hitNoteLogic (getCol c) game

handleKeys _ game = game

getNextStartTime :: ManiaGame -> Int -> Int
getNextStartTime game col = if allNotes == [] then -1000 else startTime $ head allNotes
    where allNotes = (notes game) !! col

removeItem :: [Note] -> [Note]
removeItem [] = []
removeItem (x:xs)
    | (isSlider x) = (x { beenPressed = True }):xs
    | otherwise = xs

removeNote :: Int -> ManiaGame -> ManiaGame
removeNote col game = game { notes = updateValue (notes game) (removeItem ((notes game) !! col)) col }

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
        nextStartTime = getNextStartTime game col
        hitError = abs (nextStartTime - hitOffset)


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

