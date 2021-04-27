module Render where

import Graphics.Gloss

import GameBoard
import Util

render :: ManiaGame -> Picture 
render game @ Game { gameState = Playing } = pictures notes
    where
        notes = [mkNote (begin, col, isSlider, end) | (begin, col, isSlider, end) <- (rawNotes game), begin <= windowTop]

        getX :: Int -> Float
        getX col = realToFrac (xPosition col)
            where
            xPosition col
                | col == 0 = (-noteWidth) - halfNoteWidth
                | col == 1 = (-halfNoteWidth)
                | col == 2 = halfNoteWidth
                | otherwise = noteWidth + halfNoteWidth
                where halfNoteWidth = noteWidth `div` 2 + 1

        getColor :: Int -> Color
        getColor col
            | col == 0 || col == 3 = white
            | otherwise = coolCyan

        mkSimpleNote :: Int -> Int -> Picture
        mkSimpleNote yCoord col = 
            translate (getX col) (realToFrac yCoord)
                $ color (getColor col)
                    $ rectangleSolid (realToFrac noteWidth) (realToFrac noteHeight)

        mkSlider :: Int -> Int -> Int -> Picture
        mkSlider begin col end = 
            translate (getX col) ( ((realToFrac (begin + end)) / 2) - halfNoteHeight )
                $ color (getColor col)
                    $ rectangleSolid (realToFrac noteWidth) ((realToFrac (end - begin)))
                        where halfNoteHeight = realToFrac (noteHeight `div` 2)
        
        mkNote :: (Int, Int, Bool, Int) -> Picture
        mkNote (a, b, False, _) = mkSimpleNote a b
        mkNote (a, b, True, d ) = mkSlider a b d

        --mkNote xCoord yCoord = translate (realtoFrac xCoord) (realToFrac yCoord) $ color blue $ rectangleSolid (realToFrac noteWidth) (realToFrac noteHeight)

render game @ Game { gameState = Menu } =
    pictures [ mKmenu white "haskell!mania" 0.5 0.5 (-200) 200
             , mKmenu white "Controls: D, F, J, K" 0.3 0.3 (-205) 100
             , mKmenu white "Select Map: ENTER" 0.3 0.3 (-205) (0)
             , mKmenu white "Quit: ESC" 0.3 0.3 (-205) (-100)
             ]

mKmenu :: Color -> String -> Float -> Float -> Float -> Float -> Picture
mKmenu col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text 
