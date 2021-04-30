module Movement where

import Models
import Util
import GameBoard

moveNote :: Note -> Note
moveNote note = note { startTime = (startTime note) - noteSpeed, endTime = (endTime note) - noteSpeed }

getFallenNotes :: [[Note]] -> [[Note]]
getFallenNotes list = [[note | note <- columnNotes, (endTime note) < hitOffset - 150] | columnNotes <- list]

newCombo :: ManiaGame -> Int
newCombo game = if notesCount > 0 then 0 else (combo game)
    where notesCount = sum [length x | x <- getFallenNotes (notes game)]

moveNotes :: ManiaGame -> ManiaGame
moveNotes game@ Game {gameState = Playing} =
    game { combo = newCombo game, notes = [[moveNote note | note <- columnNotes, (endTime note) >= hitOffset - 150] | columnNotes <- (notes game)], timeSinceLastHit = max ((timeSinceLastHit game) - 6) 0 }
moveNotes game@ Game {gameState = _ } = game

--moveNotes :: ManiaGame -> ManiaGame
--moveNotes game = game { combo = newCombo game, notes = [[moveNote note | note <- columnNotes, (endTime note) >= hitOffset - 150] | columnNotes <- (notes game)], timeSinceLastHit = max ((timeSinceLastHit game) - 6) 0 }
