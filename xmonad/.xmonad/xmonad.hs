-- ################################################################### -- ##                          IMPORTS                              ## -- ###################################################################

import XMonad import qualified XMonad.StackSet as W

-- Core utilities import XMonad.Util.Run (spawnPipe) import XMonad.Util.EZConfig (additionalKeysP)

-- Hooks for managing windows and bars import XMonad.Hooks.ManageDocks (docks, manageDocks, avoidStruts) import XMonad.Hooks.DynamicLog    (dynamicLogWithPP, xmobarPP, xmobarColor, shorten, PP(..))

-- Layouts import XMonad.Layout.BinarySpacePartition (emptyBSP) import XMonad.Layout.ThreeColumns         (ThreeColMid(..))

-- Layout modifiers import XMonad.Layout.Spacing    (spacingRaw, Border(..)) import XMonad.Layout.NoBorders  (smartBorders)

-- ################################################################### -- ##                         VARIABLES                             ## -- ###################################################################

myModMask :: KeyMask myModMask = mod4Mask  -- Use Super/Windows key

myTerminal :: String myTerminal = "alacritty"  -- Or st, kitty, etc.

myBorderWidth :: Dimension myBorderWidth = 2  -- Border width in pixels

myNormalBorderColor :: String myNormalBorderColor = "#282a36"  -- Unfocused windows

myFocusedBorderColor :: String myFocusedBorderColor = "#bd93f9"  -- Focused window

-- Numeric workspaces 1 through 9\ nmyWorkspaces :: [String] myWorkspaces = map show [1..9]

-- ################################################################### -- ##                        KEYBINDINGS                            ## -- ###################################################################

myKeys :: [(String, X ())] myKeys = [ -- Launch terminal ("M-S-<Return>", spawn myTerminal)

-- Application launcher
, ("M-p", spawn "dmenu_run -p 'Run:'")

  -- Close focused window
, ("M-S-c", kill)

  -- Switch layout
, ("M-<Space>", sendMessage NextLayout)
, ("M-S-<Space>", setLayout $ XMonad.layoutHook conf)

  -- Move focus
, ("M-j", windows W.focusDown)
, ("M-k", windows W.focusUp)

  -- Swap windows
, ("M-<Return>", windows W.swapMaster)
, ("M-S-j", windows W.swapDown)
, ("M-S-k", windows W.swapUp)

  -- Adjust master area
, ("M-h", sendMessage Shrink)
, ("M-l", sendMessage Expand)

  -- Restart XMonad
, ("M-q", spawn "xmonad --recompile && xmonad --restart")
]

where conf = def { layoutHook = myLayoutHook }

-- ################################################################### -- ##                           LAYOUTS                             ## -- ###################################################################

-- Add gaps: top, right, bottom, left; window gaps gaps :: l a -> ModifiedLayout Spacing l a gaps = spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True

myLayoutHook = avoidStruts $ smartBorders $ gaps emptyBSP ||| gaps (Tall 1 (3/100) (1/2)) ||| gaps (ThreeColMid 1 (3/100) (1/2)) ||| Full

-- ################################################################### -- ##                      MANAGE HOOK                              ## -- ###################################################################

myManageHook = manageDocks <+> composeAll [ className =? "Gimp" --> doFloat , className =? "mpv"  --> doFloat ]

-- ################################################################### -- ##                           MAIN                                ## -- ###################################################################

main :: IO () main = do xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc" xmonad $ docks def { terminal           = myTerminal , modMask            = myModMask , workspaces         = myWorkspaces , borderWidth        = myBorderWidth , normalBorderColor  = myNormalBorderColor , focusedBorderColor = myFocusedBorderColor

, layoutHook         = myLayoutHook
    , manageHook         = myManageHook
    , logHook            = dynamicLogWithPP xmobarPP
                            { ppOutput          = hPutStrLn xmproc
                            , ppCurrent         = xmobarColor "#50fa7b" "" . pad
                            , ppVisible         = xmobarColor "#6272a4" "" . pad
                            , ppHidden          = xmobarColor "#bd93f9" "" . pad
                            , ppHiddenNoWindows = xmobarColor "#6272a4" "" . pad
                            , ppTitle           = xmobarColor "#f8f8f2" "" . shorten 60
                            , ppSep             = " | "
                            , ppWsSep           = " "
                            }
    } `additionalKeysP` myKeys

