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

update :: Float -> ManiaGame -> ManiaGame
update seconds = moveNotes

main = do
    play window background fps initialState render handleKeys update