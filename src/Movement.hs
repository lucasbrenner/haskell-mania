module Movement where

import GameBoard
import Util

moveNotes :: ManiaGame -> ManiaGame
moveNotes game = game { rawNotes = [(begin - noteSpeed, col, isSlider, end - noteSpeed) | (begin, col, isSlider, end) <- (rawNotes game), end >= windowBottom - 11] }
