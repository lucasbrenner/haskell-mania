module Update where

import Models
import GameBoard
import Util
import System.Process
import MusicLoader

switchToPlaying :: ManiaGame -> ManiaGame
switchToPlaying game = game { gameState = Playing, score = 0, combo = 0, notes = newNotes, lastNoteScore = 0, timeSinceLastHit = 0, rawScore = 0, maxRawScore = newMaxRawScore}
    where 
        rawNotes = (mapRawNotes ((maps game) !! (levelIndex game)))
        newNotes = convertRawNotes rawNotes
        newMaxRawScore = 300 * (sum [(if trd x then 2 else 1) | x <- rawNotes])

timmingConvert :: Int -> Int
timmingConvert timming = round (((fromIntegral (timming + 1000)) * (fromIntegral fps) * (fromIntegral noteSpeed)) / 1000)

noteConvert :: (Int, Int, Bool, Int) -> Note
noteConvert (a, b, c, d)  = Note {startTime = timmingConvert a, column = b, isSlider = c, endTime = timmingConvert d, beenPressed = False}

columnCompress :: [(Int, Int, Bool, Int)] -> Int -> [Note]
columnCompress rawNotes col = [noteConvert note | note <- rawNotes, snd' note == col]

convertRawNotes :: [(Int, Int, Bool, Int)] -> [[Note]]
convertRawNotes rawNotes = [ columnCompress rawNotes col | col <- [0..3]]

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

getMusic :: IO String
getMusic = readProcess "gnome-terminal" ["--", "play", mapDir ++ ((loadMusics) !!1)] ""

finishMusic :: IO String
finishMusic = readProcess "pkill" ["-f",".mp3"] ""
