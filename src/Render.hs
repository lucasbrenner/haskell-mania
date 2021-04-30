module Render where

import Graphics.Gloss
import Numeric

import Models
import Util
import GameBoard

{-
    Function that renders the game.
-}
render :: ManiaGame -> Picture 
render game @ Game { gameState = Playing } = pictures
    [ notes1
    , showScore
    , showCombo
    , hitPlace
    , hitLimit
    , keyPress
    , lastHit
    , showAccuracy
    ]
    where
        rawNotes = [[mkNote note | note <- columnNotes] | columnNotes <- (notes game)]

        notes1 = pictures [pictures column | column <- rawNotes]

        getX :: Int -> Float
        getX col = realToFrac ((xPosition col) - ((width `div` 2) - 2 * noteWidth) + 10)
            where
            xPosition col
                | col == 0 = (-noteWidth) - halfNoteWidth
                | col == 1 = (-halfNoteWidth)
                | col == 2 = halfNoteWidth
                | otherwise = noteWidth + halfNoteWidth
                where halfNoteWidth = noteWidth `div` 2 + 1

        showScore = mkMenu coolCyan (show (score game)) 0.5 0.5 100 270

        showCombo = mkMenu coolCyan ((show (combo game)) ++ "x") 0.5 0.5 100 170

        getAccuracy :: ManiaGame -> Float
        getAccuracy game = (realToFrac (rawScore game)) / (realToFrac (maxRawScore game)) * 100.0

        showAccuracy = mkMenu coolCyan ( (showFFloat (Just 2) (getAccuracy game) "") ++ "%") 0.5 0.5 100 (-50)

        lastHitText = mkMenu (snd values) (fst values) 0.5 0.5 (-200) 100
            where
            values
                | lastScore == 300 = ("GOOD", coolCyan)
                | lastScore == 200 = ("OK", light green)
                | lastScore == 100 = ("BAD", light red)
                | otherwise = ("MISS", red)
                where lastScore = (lastNoteScore game)

        lastHit = if (timeSinceLastHit game > 0)
                  then lastHitText
                  else pictures []

        getColor :: Int -> Color
        getColor col
            | col == 0 || col == 3 = white
            | otherwise = coolCyan

        mkSimpleNote :: Int -> Int -> Picture
        mkSimpleNote yCoord col = 
            translate (getX col) (realToFrac yCoord)
                $ color (getColor col)
                    $ rectangleSolid (realToFrac noteWidth) (realToFrac noteHeight)

        mkSlider :: Int -> Int -> Int -> Bool -> Picture
        mkSlider originalBegin col end beenPressed = 
            translate (getX col) ( ((realToFrac (begin + end)) / 2) - halfNoteHeight )
                $ color (getColor col)
                    $ rectangleSolid (realToFrac noteWidth) ((realToFrac (end - begin)))
                        where
                            halfNoteHeight = realToFrac (noteHeight `div` 2)
                            begin = if beenPressed then hitOffset else originalBegin
        
        mkNote :: Note -> Picture
        mkNote note
            | slider = mkSlider (startTime note) (column note) (endTime note) (beenPressed note)
            | otherwise = mkSimpleNote (startTime note) (column note)
            where slider = (isSlider note)

        mkMenu :: Color -> String -> Float -> Float -> Float -> Float -> Picture
        mkMenu col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text 

        mkHitPlace :: Int -> Color -> Picture
        mkHitPlace col picColor =
            translate (getX col) (realToFrac hitOffset)
                $ color picColor
                    $ rectangleSolid (realToFrac (noteWidth + 1)) (realToFrac (noteHeight `div` 8))

        mkHitLimit :: Int -> Color -> Picture
        mkHitLimit hitError picColor =
            translate (realToFrac ((getX 3) + (fromIntegral (noteWidth `div` 2)) + 10)) (realToFrac hitOffset)
                $ color picColor
                    $ rectangleSolid (realToFrac 5) (realToFrac (hitError * 2))
        
        hitPlace = pictures [mkHitPlace x coolCyan | x <- [0..3]]

        hitLimit = pictures [mkHitLimit 150 (light red), mkHitLimit 90 (light green), mkHitLimit 30 coolCyan]

        keyPress = pictures [mkHitPlace x red | x <- [0..3], (buttons game) !! x]


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
             , mkText yellow (title ((maps game)!!4)) 0.3 0.3 (-80) (rectHeights!!4)

             , mkRectangle white 500 100 0 (rectHeights!!5)
             , mkText red (title ((maps game)!!5)) 0.3 0.3 (-80) (rectHeights!!5)
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
