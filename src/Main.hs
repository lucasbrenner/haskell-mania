module Main where

import Graphics.Gloss
import Debug.Trace

import GameBoard
import Render
import EventHandler
import Movement
import Models
import Util

import System.Process

window :: Display
window = InWindow "haskell!mania" (width, height) (xOffset, yOffset)

--update :: Float -> ManiaGame -> ManiaGame

update :: Float -> ManiaGame -> ManiaGame
--update seconds game = trace (show game) (moveNotes game)
update seconds = moveNotes

main = do
    --getMusic
    play window background fps initialState render handleKeys update