module Main where

import Graphics.Gloss

window :: Display
window = InWindow "ok" (200, 200) (500, 500)

background :: Color
background = white

drawing :: Picture
drawing = circle 80

main :: IO ()
main = display window background drawing
