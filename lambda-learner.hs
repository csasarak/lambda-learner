module Main where

import LambdaGUI
import Graphics.UI.WX hiding (Event)
import Reactive.Banana
import Reactive.Banana.WX

main :: IO ()
main = start mainWindowDef
