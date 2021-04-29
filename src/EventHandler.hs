module EventHandler where

import Models
import GameBoard
import Graphics.Gloss.Interface.Pure.Game

handleKeys :: Event -> ManiaGame -> ManiaGame

handleKeys (EventKey (SpecialKey KeyDown) Down _ _  ) game@ Game { gameState = MapSelector } =
    game { firstMapHeight = (firstMapHeight game) + 110}

handleKeys (EventKey (SpecialKey KeyUp) Down _ _  ) game@ Game { gameState = MapSelector } =
    game { firstMapHeight = (firstMapHeight game) - 110}

handleKeys _ game = game