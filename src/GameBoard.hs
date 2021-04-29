module GameBoard where

import Graphics.Gloss
import MapLoader
import Models

background :: Color
background = black

width, height, xOffset, yOffset :: Int
width = 700
height = 700
xOffset = 600
yOffset = 10

noteWidth, noteHeight, noteSpeed :: Int
noteWidth = 115
noteHeight = 50
noteSpeed = 24

windowTop, windowBottom, windowLeft, windowRight :: Int
windowTop = round $ (fromIntegral height) / 2
windowBottom = -(round $ (fromIntegral height) / 2)
windowLeft = -(round $ (fromIntegral width) / 2)
windowRight = round $ (fromIntegral width) / 2

fps :: Int
fps = 60

firstMapInitialHeight :: Int
firstMapInitialHeight = 220

timmingColumns :: [(Int, Int, Bool, Int)]
timmingColumns =
    [ (27, 2, False, 27)
    , (27, 3, False, 27)
    , (188, 1, False, 188)
    , (349, 2, False, 349)
    , (510, 3, False, 510)
    , (833, 0, False, 833)
    , (994, 1, False, 994)
    , (1156, 2, False, 1156)
    , (1478, 3, False, 1478)
    , (1639, 2, False, 1639)
    , (1801, 0, False, 1801)
    , (1962, 1, False, 1962)
    , (2123, 2, False, 2123)
    , (2285, 1, False, 2285)
    , (2446, 0, False, 2446)
    , (2607, 2, False, 2607)
    , (2768, 1, False, 2768)
    , (2930, 2, False, 2930)
    , (3091, 3, False, 3091)
    , (3414, 0, False, 3414)
    , (3575, 1, False, 3575)
    , (3736, 2, False, 3736)
    , (4059, 3, False, 4059)
    , (4220, 1, False, 4220)
    , (4381, 2, False, 4381)
    , (4543, 0, False, 4543)
    , (4704, 1, False, 4704)
    , (4865, 2, False, 4865)
    , (5026, 1, False, 5026)
    ]

timmingConvert :: Int -> Int
timmingConvert timming = round ((fromIntegral timming) * 0.06 * (fromIntegral noteSpeed))

initialState :: ManiaGame
initialState = Game
    { buttons = [False]
    , gameState = MapSelector
    , score = 0
    , rawNotes = [(timmingConvert begin, col, isSlider, timmingConvert end) | (begin, col, isSlider, end) <- timmingColumns]
    , firstMapHeight = firstMapInitialHeight
    , maps = loadMaps
    }