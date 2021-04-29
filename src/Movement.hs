module Movement where

import GameBoard
import Util

moveNote :: Note -> Note
moveNote note = note { startTime = (startTime note) - noteSpeed, endTime = (endTime note) - noteSpeed }

moveNotes :: ManiaGame -> ManiaGame
moveNotes game = game { notes = [[moveNote note | note <- columnNotes, (endTime note) >= hitOffset - 250] | columnNotes <- (notes game)] }
--moveNotes game = game { notes = [(begin - noteSpeed, col, isSlider, end - noteSpeed) | (begin, col, isSlider, end) <- (rawNotes game), end >= windowBottom - 11] }
