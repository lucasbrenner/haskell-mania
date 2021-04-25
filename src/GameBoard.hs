module GameBoard where

import Graphics.Gloss

background :: Color
background = black

width, height, offset :: Int
width = 400
height = 800
offset = 200

noteWidth, noteHeight, noteSpeed :: Int
noteWidth = 40
noteHeight = 10
noteSpeed = 10

fps :: Int
fps = 60

data GameState = 
    Playing | Menu
    deriving Show


data ManiaGame = Game
    { buttons :: [Bool]
    , gameState :: GameState
    , score :: Int
    , notesCoords :: [Int]
    } deriving Show


initialState :: ManiaGame
initialState = Game
    { buttons = [False]
    , gameState = Playing
    , score = 0
    , notesCoords = [round ((fromIntegral x) * 0.06 * (fromIntegral noteSpeed))  | x <- [100, 200, 500, 1500, 1535, 2000, 10000]]
    }
