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
    hitNoteLogic col ( insertHitAnimation col game )
    where col = getCol c

handleKeys (EventKey (Char c) Up _ _) game@ Game { gameState = Playing } =
    releaseNoteLogic col ( removeHitAnimation col game )
    where col = getCol c

handleKeys _ game = game

insertHitAnimation :: Int -> ManiaGame -> ManiaGame
insertHitAnimation (-1) game = game
insertHitAnimation col game = game { buttons = updateValue (buttons game) True col }

removeHitAnimation :: Int -> ManiaGame -> ManiaGame
removeHitAnimation (-1) game = game
removeHitAnimation col game = game { buttons = updateValue (buttons game) False col }

getNextStartTime :: ManiaGame -> Int -> Int
getNextStartTime game col = if allNotes == [] then -1000 else startTime $ head allNotes
    where allNotes = (notes game) !! col

getNextEndTime :: ManiaGame -> Int -> Int
getNextEndTime game col = if allNotes == [] then -1000 else endTime $ head allNotes
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
    where newCombo = if scoreByHitError hitError > 0 then (combo game) + 1 else 0

updateScore :: Int -> ManiaGame -> ManiaGame
updateScore hitError game = game {score = (score game) + noteScore + 20 * ((combo game) `div` 50), rawScore = (rawScore game) + noteScore}
    where
        noteScore = scoreByHitError hitError

updateLastHit :: Int -> ManiaGame -> ManiaGame
updateLastHit hitError game = game { lastNoteScore = scoreByHitError hitError, timeSinceLastHit = 50 }

hitNoteLogic :: Int -> ManiaGame -> ManiaGame
hitNoteLogic (-1) game = game
hitNoteLogic col game = removeNote col $ updateCombo hitError $ updateScore hitError $ updateLastHit hitError game
    where
        nextStartTime = getNextStartTime game col
        hitError = abs (nextStartTime - hitOffset)

releaseRemoveItem :: [Note] -> [Note]
releaseRemoveItem [] = []
releaseRemoveItem (x:xs)
    | (isSlider x) && (beenPressed x) = xs
    | otherwise = (x:xs)

releaseRemoveNote :: Int -> ManiaGame -> ManiaGame
releaseRemoveNote col game = game { notes = updateValue (notes game) (releaseRemoveItem ((notes game) !! col)) col }

inSlider :: Int -> ManiaGame -> Bool
inSlider col game
    | getNextStartTime game col == -1000 = False
    | beenPressed (head ((notes game) !! col)) = True
    | otherwise = False

releaseNoteLogic :: Int -> ManiaGame -> ManiaGame
releaseNoteLogic (-1) game = game
releaseNoteLogic col game = if inSlider col game
                            then releaseRemoveNote col $ updateCombo hitError $ updateScore hitError $ updateLastHit hitError game
                            else game
    where
        nextEndTime = getNextEndTime game col
        hitError = abs (nextEndTime - hitOffset)


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

