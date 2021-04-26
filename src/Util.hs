module Util where

import Graphics.Gloss

fst' (a, _, _, _) = a
snd' (_, a, _, _) = a
trd (_, _, a, _) = a
frth (_, _, _, a) = a

coolCyan :: Color
coolCyan = makeColorI 53 200 254 255
