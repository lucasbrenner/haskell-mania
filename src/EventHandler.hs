module EventHandler where

import Models
import GameBoard
import Graphics.Gloss.Interface.Pure.Game

import Util
import MapLoader
import MusicLoader
import Update

getCol :: Char -> Int
getCol 'd' = 0
getCol 'f' = 1
getCol 'j' = 2
getCol 'k' = 3
getCol _   = -1

handleKeys :: Event -> ManiaGame -> ManiaGame

handleKeys (EventKey (SpecialKey KeyEnter) Down _ _  ) game@ Game { gameState = Menu} =
   game { gameState = MapSelector }


handleKeys (EventKey (SpecialKey KeyDown) Down _ _  ) game@ Game { gameState = MapSelector } =
    game { firstMapHeight = min ((firstMapHeight game) + 110) 550
         , levelIndex = min ((levelIndex game) + 1) 5}

handleKeys (EventKey (SpecialKey KeyUp) Down _ _  ) game@ Game { gameState = MapSelector } =
    game { firstMapHeight = max ((firstMapHeight game) - 110) 0
         , levelIndex = max ((levelIndex game) - 1) 0}

handleKeys (EventKey (SpecialKey KeyEnter) Down _ _  ) game@ Game { gameState = MapSelector } =
   switchToPlaying game


handleKeys (EventKey (Char 'p') Down _ _  ) game@ Game { gameState = Playing} =
   game { gameState = MapSelector }

handleKeys (EventKey (Char c) Down _ _) game@ Game { gameState = Playing } =
    hitNoteLogic col ( insertHitAnimation col game )
    where col = getCol c

handleKeys (EventKey (Char c) Up _ _) game@ Game { gameState = Playing } =
    releaseNoteLogic col ( removeHitAnimation col game )
    where col = getCol c

handleKeys _ game = game
