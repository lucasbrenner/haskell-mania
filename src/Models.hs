module Models where

data GameState = 
    Playing | Menu | MapSelector
    deriving Show

data ManiaMap = ManiaMap
    { title :: String
    , artist :: String
    , difficulty :: String
    , mapRawNotes :: [(Int, Int, Bool, Int)] -- [(startTime, column, isSlider, endTime)]
    } deriving Show

data ManiaGame = Game
    { buttons :: [Bool]
    , gameState :: GameState
    , score :: Int
    , rawNotes :: [(Int, Int, Bool, Int)] -- timming, collumn, isSlider, sliderEndTimming
    , firstMapHeight :: Int -- height of the first rectangle in the map selector
    , maps :: [ManiaMap]
    , combo :: Int
    } deriving Show
