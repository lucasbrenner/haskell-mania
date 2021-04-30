module Render where

import Graphics.Gloss

import GameBoard
import Util
import Numeric

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




        --mkNote xCoord yCoord = translate (realtoFrac xCoord) (realToFrac yCoord) $ color blue $ rectangleSolid (realToFrac noteWidth) (realToFrac noteHeight)

render game @ Game { gameState = Menu } =
    pictures [ mKmenu white "haskell!mania" 0.5 0.5 (-200) 200
             , mKmenu white "Controls: D, F, J, K" 0.3 0.3 (-205) 100
             , mKmenu white "Select Map: ENTER" 0.3 0.3 (-205) (0)
             , mKmenu white "Quit: ESC" 0.3 0.3 (-205) (-100)
             ]

mKmenu :: Color -> String -> Float -> Float -> Float -> Float -> Picture
mKmenu col text x y x' y' = translate x' y' $ scale x y $ color col $ Text text 
