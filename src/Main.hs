module Main where

import Graphics.Gloss
import Debug.Trace

import GameBoard
import Render
import EventHandler
import Movement
import Models

import System.Process

window :: Display
window = InWindow "haskell!mania" (width, height) (xOffset, yOffset)

--update :: Float -> ManiaGame -> ManiaGame
--update seconds game = trace (show game) (moveNotes game)

update :: Float -> ManiaGame -> ManiaGame
update seconds = moveNotes

main = do
    readProcess "gnome-terminal" ["--", "play", "imagine-dragons-believer.mp3"] ""
    play window background fps initialState render handleKeys update
