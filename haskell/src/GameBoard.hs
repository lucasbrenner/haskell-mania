module GameBoard where

import Graphics.Gloss
import MapLoader
import Models

import MapLoader
import Models

background :: Color
background = black

width, height, xOffset, yOffset :: Int
width = 700
height = 700
xOffset = 600
yOffset = 0

noteWidth, noteHeight, noteSpeed, hitOffset :: Int
noteWidth = 89
noteHeight = 38
noteSpeed = 15
hitOffset = (-(width `div` 2)) + 110

windowTop, windowBottom, windowLeft, windowRight :: Int
windowTop = round $ (fromIntegral height) / 2
windowBottom = -(round $ (fromIntegral height) / 2)
windowLeft = -(round $ (fromIntegral width) / 2)
windowRight = round $ (fromIntegral width) / 2

scoreByHitError :: Int -> Int
scoreByHitError hitError
    | hitError <= 30 = 300
    | hitError <= 90 = 200
    | hitError <= 150 = 100
    | otherwise = 0

fps :: Int
fps = 60

firstMapInitialHeight :: Int
firstMapInitialHeight = 220

initialState :: ManiaGame
initialState = Game
    { buttons = [False, False, False, False]
    , gameState = Menu
    , score = 0
    , combo = 0
    , notes = []
    , firstMapHeight = firstMapInitialHeight
    , lastNoteScore = 0
    , timeSinceLastHit = 0
    , rawScore = 0
    , maxRawScore = 0
    , maps = loadMaps
    , levelIndex = 2
    }
