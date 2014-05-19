
module LambdaGUI where

import Graphics.UI.WX hiding (Event)
import Reactive.Banana
import Reactive.Banana.WX

-- A specification for the main GUI window, can be used by the event network
mainWindowDef :: IO()
mainWindowDef = do 
    f <- frame [text := "Lambda Learner"]
    
    -- Construct the file menu
    fileMenu <- menuPane [text := "File"]
    fileOpen <- menuItem fileMenu [text := "Open..."]
    menuLine fileMenu
    quit <- menuQuit fileMenu [help := "Quit the editor"]
    
    -- CMS: If we need to do cleanup operations, this should be moved to the network
    -- description I think
    set quit [on command := close f]

    -- Construct panes
    editorP1 <- textCtrl f []
    editorP2 <- textCtrl f []

    -- buttons 
    buttonPanel <- panel f []
    quitButton <- button buttonPanel [text := "Quit"]

    set f [menuBar := [fileMenu], layout := margin 5 $ column 5 [
            -- Button panel at the top
            hstretch $ container buttonPanel $ row 5 [widget quitButton],
            -- The text area widgets
             row 5 [fill $ widget editorP1, 
                 fill $ widget editorP2]
            ]]
