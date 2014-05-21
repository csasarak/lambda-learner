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
    fileOpenMI <- menuItem fileMenu [text := "Open..."]
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
    -- Now describe the event network
    let networkDescription :: forall t. Frameworks t => Moment t ()
        networkDescription = do
            -- Event t ()
            eStep <- event0 stepButton command

            -- command when a file is opened
            -- CMS: I have no idea why, but this seems to fire twice per click
            efileOpen <- event0 fileOpenMI command

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
                interpretText = do txt <- pickPaneText
                                   set editorP2 [text := stepStr txt]

                -- Set text in the behavior to ""
                clear = "" <$ p1Txt                           
                
                
                                            
            sink editorP2 [ text :== clear ]
            --reactimate $ (const return ) <$> efileOpen
            reactimate $ const interpretText <$> eStep
            reactimate $ const (do p <- openFile f 
                                   fileContents <- (if p /= "" then
                                                        readFile p
                                                    else
                                                        return =<< get editorP1 text)
                                   set editorP1 [text := fileContents]) <$> efileOpen
    network <- compile networkDescription
    actuate network

stepStr :: String -> String
stepStr =  (fromMaybe "") . fmap show . I.stepText

openFile :: Window a -> IO (String)
openFile parent = do mPath <-fileOpenDialog parent True True "Select lc file" 
                        [("lc", ["*.lc"]), 
                         ("Any file", ["*.*"])] "" ""
                     return $ DM.fromMaybe "" mPath
