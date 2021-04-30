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
    , combo :: Int
    , notes :: [[Note]] -- timming, collumn, isSlider, sliderEndTimming
    , firstMapHeight :: Int -- height of the first rectangle in the map selector
    , lastNoteScore :: Int
    , timeSinceLastHit :: Int
    , rawScore :: Int
    , maxRawScore :: Int
    , maps :: [ManiaMap]
    } deriving Show

data Note = Note
    { startTime :: Int
    , column :: Int
    , isSlider :: Bool
    , endTime :: Int
    , beenPressed :: Bool
    } deriving (Show, Eq)
