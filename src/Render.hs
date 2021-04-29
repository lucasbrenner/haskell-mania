module Render where

import Graphics.Gloss

import Models
import Util
import GameBoard

render :: ManiaGame -> Picture 
render game @ Game { gameState = Playing } = pictures
    [ pictures notes
    ]
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
        mkSimpleNote yCoord col = translate (getX col) (realToFrac yCoord) $ color (getColor col) $ rectangleSolid (realToFrac noteWidth) (realToFrac noteHeight)

        mkSlider :: Int -> Int -> Int -> Picture
        mkSlider yCoord col endYCoord = circle 5 -- TODO
        
        mkNote :: (Int, Int, Bool, Int) -> Picture
        mkNote (a, b, False, _) = mkSimpleNote a b
        mkNote (a, b, True, d ) = mkSlider a b d

        --mkNote xCoord yCoord = translate (realtoFrac xCoord) (realToFrac yCoord) $ color blue $ rectangleSolid (realToFrac noteWidth) (realToFrac noteHeight)
{-
    Function that renders the map selector.
-}
render game @ Game { gameState = MapSelector } = 
    pictures [ mkRectangle coolCyan 510 110 0 0 --highlight
             , mkRectangle white 500 100 0 (rectHeights!!0) --rectangle to place the map info
             , mkText green (title ((maps game)!!0)) 0.3 0.3 (-150) (rectHeights!!0) --map title
            
             , mkRectangle white 500 100 0 (rectHeights!!1)
             , mkText yellow (title ((maps game)!!1)) 0.3 0.3 (-150) (rectHeights!!1)

             , mkRectangle white 500 100 0 (rectHeights!!2) --(...)
             , mkText red (title ((maps game)!!2)) 0.3 0.3 (-150) (rectHeights!!2)

             , mkRectangle white 500 100 0 (rectHeights!!3)
             , mkText green (title ((maps game)!!3)) 0.3 0.3 (-80) (rectHeights!!3)

             , mkRectangle white 500 100 0 (rectHeights!!4)
             , mkText yellow (title ((maps game)!!3)) 0.3 0.3 (-80) (rectHeights!!4)

             , mkRectangle white 500 100 0 (rectHeights!!5)
             , mkText red (title ((maps game)!!3)) 0.3 0.3 (-80) (rectHeights!!5)
             ] where rectHeights = take 10 [fromIntegral x :: Float | x <- [firstMapHeight game, (firstMapHeight game)-110..]]
{-
    Function that renders the game menu.
-}
render game @ Game { gameState = Menu } =
    pictures [ mkText white "haskell!mania" 0.5 0.5 (-200) 200
             , mkText white "Controls: D, F, J, K" 0.3 0.3 (-205) 100
             , mkText white "Select Map: ENTER" 0.3 0.3 (-205) (0)
             , mkText white "Quit: ESC" 0.3 0.3 (-205) (-100)
             ]

{-
    Function that renders text at a given position with a given size.
    
    col: text color
    text: the text to be rendered
    x, y: the size of the text
    x', y': the position of the text on the scren
-}
mkText :: Color -> String -> Float -> Float -> Float -> Float -> Picture
mkText col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text

{-
    Function that renders a rectangle at a given position with a given size.
    
    col: rectangle color
    x, y: the size of the rectangle
    x', y': the position of the rectangle
-}
mkRectangle :: Color -> Float -> Float -> Float -> Float -> Picture
mkRectangle col x y x' y' = translate x' y' $ color col $ rectangleSolid x y