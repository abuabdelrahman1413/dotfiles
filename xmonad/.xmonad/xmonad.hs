import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Layout.Dwindle
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run (spawnPipe)
import System.IO (hPutStrLn)

-- Dwindle layout: start from the right, spiral clockwise
myLayout = Dwindle R CW 1.5 1.1 ||| Full

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ def
      { modMask            = mod4Mask
      , borderWidth        = 1
      , normalBorderColor  = "#cccccc"
      , focusedBorderColor = "#cd8b00"
      , layoutHook         = myLayout
      , logHook = dynamicLogWithPP xmobarPP
          { ppOutput = hPutStrLn xmproc
          , ppTitle  = xmobarColor "#cd8b00" "" . shorten 60
          }
      }
      `additionalKeysP`
      [ ("M-S-z", spawn "xscreensaver-command -lock")
      , ("M-<Return>", spawn "alacritty")
      , ("M-d", spawn "dmenu_run")
      , ("M-q", kill)
      , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
      , ("M-h", sendMessage Shrink)
      , ("M-l", sendMessage Expand)
      ]
