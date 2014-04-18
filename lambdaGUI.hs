
module Main where

import Graphics.UI.WX hiding (Event)
import Reactive.Banana
import Reactive.Banana.WX

main :: IO ()
main = start mainWindow

mainWindow :: IO()
mainWindow = do 
    f <- frame [text := "Lambda Learner"]
    
    -- Construct the file menu
    fileMenu <- menuPane [text := "File"]
    menuLine fileMenu
    quit <- menuQuit fileMenu [help := "Quit the editor"]
    
    set quit [on command := close f]

    set f [menuBar := [fileMenu]]
