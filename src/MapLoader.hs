module MapLoader where

import Util
import Models

loadMaps :: [ManiaMap]
loadMaps = [ loadMap "AKITO_-_Sakura_Kagetsu_ZZHBOY_easy.hmania"
           , loadMap "AKITO_-_Sakura_Kagetsu_ZZHBOY_normal.hmania"
           , loadMap "AKITO_-_Sakura_Kagetsu_ZZHBOY_hard.hmania"
           , loadMap "ginkiha_-_Anemoi__A_v_a_l_o_n__Easy.hmania"
           , loadMap "ginkiha_-_Anemoi__A_v_a_l_o_n__Normal.hmania"
           , loadMap "ginkiha_-_Anemoi__A_v_a_l_o_n__Hard.hmania"
           ]
