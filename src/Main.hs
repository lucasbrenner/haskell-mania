module Main where

import Graphics.Gloss

import GameBoard
import Render
import EventHandler
import Movement


window :: Display
window = InWindow "haskell!mania" (width, height) (offset, offset)

update :: Float -> ManiaGame -> ManiaGame
update seconds = moveNotes

main :: IO ()
main = play window background fps initialState render handleKeys update
