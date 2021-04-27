module GameBoard where

import Graphics.Gloss

background :: Color
background = black

width, height, xOffset, yOffset :: Int
width = 700
height = 700
xOffset = 600
yOffset = 0

noteWidth, noteHeight, noteSpeed :: Int
noteWidth = 115
noteHeight = 50
noteSpeed = 24

windowTop, windowBottom, windowLeft, windowRight :: Int
windowTop = round $ (fromIntegral height) / 2
windowBottom = -(round $ (fromIntegral height) / 2)
windowLeft = -(round $ (fromIntegral width) / 2)
windowRight = round $ (fromIntegral width) / 2

fps :: Int
fps = 60

data GameState = 
    Playing | Menu
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
    } deriving Show

timmingColumns :: [(Int, Int, Bool, Int)]
timmingColumns =
    [ (27, 2, False, 27)
    , (27, 3, False, 27)
    , (188, 1, False, 188)
    , (349, 2, False, 349)
    , (510, 3, False, 510)
    , (833, 0, False, 833)
    , (994, 1, False, 994)
    , (1156, 2, False, 1156)
    , (1478, 3, False, 1478)
    , (1639, 2, False, 1639)
    , (1801, 0, False, 1801)
    , (1962, 1, False, 1962)
    , (2123, 2, False, 2123)
    , (2285, 1, False, 2285)
    , (2446, 0, False, 2446)
    , (2607, 2, False, 2607)
    , (2768, 1, False, 2768)
    , (2930, 2, False, 2930)
    , (3091, 3, False, 3091)
    , (3414, 0, False, 3414)
    , (3575, 1, False, 3575)
    , (3736, 2, False, 3736)
    , (4059, 3, False, 4059)
    , (4220, 1, False, 4220)
    , (4381, 2, False, 4381)
    , (4543, 0, False, 4543)
    , (4704, 1, False, 4704)
    , (4865, 2, False, 4865)
    , (5026, 1, False, 5026)
    , (5188, 2, False, 5188)
    , (5349, 3, False, 5349)
    , (5510, 1, False, 5510)
    , (5672, 2, False, 5672)
    , (5994, 0, False, 5994)
    , (6156, 1, False, 6156)
    , (6317, 2, False, 6317)
    , (6639, 3, False, 6639)
    , (6801, 1, False, 6801)
    , (6962, 2, False, 6962)
    , (7123, 3, False, 7123)
    , (7285, 1, False, 7285)
    , (7446, 2, False, 7446)
    , (7607, 0, False, 7607)
    , (7768, 1, False, 7768)
    , (7930, 3, False, 7930)
    , (8091, 0, False, 8091)
    , (8252, 2, False, 8252)
    , (8575, 1, False, 8575)
    , (8736, 2, False, 8736)
    , (8897, 3, False, 8897)
    , (9220, 1, False, 9220)
    , (9381, 0, False, 9381)
    , (9543, 1, False, 9543)
    , (9704, 2, False, 9704)
    , (9865, 3, False, 9865)
    , (10026, 0, False, 10026)
    , (10188, 1, False, 10188)
    , (10349, 2, False, 10349)
    , (10349, 3, True, 12123)
    , (10510, 0, False, 10510)
    , (10672, 2, False, 10672)
    , (10833, 0, False, 10833)
    , (11156, 1, False, 11156)
    , (11317, 2, False, 11317)
    , (11478, 0, False, 11478)
    , (11801, 1, False, 11801)
    , (11962, 0, False, 11962)
    , (12123, 1, False, 12123)
    , (12285, 2, True, 12930)
    , (12446, 0, False, 12446)
    , (12607, 1, False, 12607)
    , (12768, 3, False, 12768)
    , (12930, 1, True, 14704)
    , (13091, 3, False, 13091)
    , (13252, 0, False, 13252)
    , (13414, 2, False, 13414)
    , (13736, 0, False, 13736)
    , (13897, 3, False, 13897)
    , (14059, 2, False, 14059)
    , (14381, 3, False, 14381)
    , (14543, 0, False, 14543)
    , (14704, 2, False, 14704)
    , (14865, 0, True, 15510)
    , (15026, 3, False, 15026)
    , (15188, 2, False, 15188)
    , (15349, 3, False, 15349)
    , (15510, 1, True, 17285)
    , (15672, 2, False, 15672)
    , (15833, 0, False, 15833)
    , (15994, 3, False, 15994)
    , (16317, 0, False, 16317)
    , (16478, 2, False, 16478)
    , (16639, 3, False, 16639)
    , (16962, 0, False, 16962)
    , (17123, 2, False, 17123)
    , (17285, 0, False, 17285)
    , (17446, 3, True, 18091)
    , (17607, 1, False, 17607)
    , (17768, 2, False, 17768)
    , (17930, 0, False, 17930)
    , (18091, 1, False, 18091)
    , (18252, 1, False, 18252)
    , (18414, 3, False, 18414)
    , (18575, 3, False, 18575)
    , (18736, 0, False, 18736)
    , (18897, 0, False, 18897)
    , (19059, 2, False, 19059)
    , (19220, 2, False, 19220)
    , (19381, 0, False, 19381)
    , (19462, 1, False, 19462)
    , (19543, 3, False, 19543)
    , (19623, 2, False, 19623)
    , (19704, 0, False, 19704)
    , (19785, 1, False, 19785)
    , (19865, 3, False, 19865)
    , (19946, 2, False, 19946)
    , (20026, 0, False, 20026)
    , (20107, 1, False, 20107)
    , (20188, 3, False, 20188)
    , (20268, 2, False, 20268)
    , (20349, 0, True, 20672)
    , (20349, 1, True, 20672)
    , (20672, 2, False, 20672)
    , (20672, 3, True, 22446)
    , (20994, 0, False, 20994)
    , (20994, 1, False, 20994)
    , (21478, 2, False, 21478)
    , (21639, 1, False, 21639)
    , (21639, 0, False, 21639)
    , (21962, 2, False, 21962)
    , (22285, 1, False, 22285)
    , (22285, 0, False, 22285)
    , (22607, 0, True, 23252)
    , (22768, 2, False, 22768)
    , (22930, 1, False, 22930)
    , (22930, 3, False, 22930)
    , (23252, 3, False, 23252)
    , (23252, 2, True, 25026)
    , (23575, 0, False, 23575)
    , (23575, 1, False, 23575)
    ]

timmingConvert :: Int -> Int
timmingConvert timming = round (((fromIntegral timming) * (fromIntegral fps) * (fromIntegral noteSpeed)) / 1000)


initialState :: ManiaGame
initialState = Game
    { buttons = [False]
    , gameState = Menu
    , score = 0
    , rawNotes = [(timmingConvert begin, col, isSlider, timmingConvert end) | (begin, col, isSlider, end) <- timmingColumns]
    }
