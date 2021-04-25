module Movement where

import GameBoard

moveNotes :: ManiaGame -> ManiaGame
moveNotes game = game { notesCoords = [y - noteSpeed | y <- (notesCoords game), y >= round (- ((fromIntegral height) / 2))] }
