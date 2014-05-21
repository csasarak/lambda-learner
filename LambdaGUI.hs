module LambdaGUI where

import Graphics.UI.WX hiding (Event)
import Reactive.Banana
import Reactive.Banana.WX
import Interpreter as I
import Parser as P
import Data.Maybe as DM
import Control.Exception 

{-# LANGUAGE ScopedTypeVariables #-} -- allows "forall t. Moment t"

-- A specification for the main GUI window, can be used by the event network
mainWindowDef :: IO()
mainWindowDef = do 
    f <- frame [text := "Lambda Learner"]
    
    -- Construct the file menu
    fileMenu <- menuPane [text := "File"]
    -- fileOpen <- menuItem fileMenu [text := "Open..."]
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
    quitButton <- button buttonPanel [text := "Quit", on command := close f]
    stepButton <- button buttonPanel [text := "Step"]

    -- Lay out the widgets
    set f [menuBar := [fileMenu], layout := margin 5 $ column 5 [
            -- Button panel at the top
            hstretch $ container buttonPanel $ row 5 [widget quitButton, widget stepButton],
            -- The text area widgets
             row 5 [fill $ widget editorP1, 
                 fill $ widget editorP2]
            ]]
    let networkDescription :: forall t. Frameworks t => Moment t ()
        networkDescription = do
            -- Event t ()
            eStep <- event0 stepButton command
            -- Behavior t String
            p1Txt <- behaviorText editorP1 ""

            let
                
                pickPaneText :: IO (String)
                pickPaneText = do txtP2 <- get editorP2 text 
                                  (if txtP2 == "" then
                                    get editorP1 text
                                   else
                                    return txtP2)

                -- Lambda: if txtP2 is not empty. If it isn't, use current 
                -- contents of txtP2 step. 
                -- interpretText :: Event t (IO ())
                interpretText = const (do txt <- pickPaneText
                                          set editorP2 [text := stepStr txt]) <$> eStep
                clear = "" <$ p1Txt                           
                                            
                -- stepIntTxt = stepper (return "") 
                
            sink editorP2 [ text :== clear ]
            reactimate interpretText
    network <- compile networkDescription
    actuate network

stepStr :: String -> String
stepStr =  (fromMaybe "") . fmap show . I.stepText
