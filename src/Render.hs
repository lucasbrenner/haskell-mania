module Render where

import Graphics.Gloss
import GameBoard

render :: ManiaGame -> Picture 
render game @ Game { gameState = Playing } = pictures
    [ pictures notes
    ]
    where
        notes = [mkNote x | x <- (notesCoords game), x <= round ((fromIntegral height) / 2)]

        mkNote :: Int -> Picture
        mkNote coord = translate 0 (realToFrac coord) $ color blue $ rectangleSolid (realToFrac noteWidth) (realToFrac noteHeight)
