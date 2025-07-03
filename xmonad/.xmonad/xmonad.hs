--  ██╗  ██╗ ██████╗  ██████╗ ███╗   ██╗  ██████╗  █████╗  ██████╗
--  ╚██╗██╔╝██╔═══██╗██╔═══██╗████╗  ██║ ██╔═══██╗██╔══██╗██╔════╝
--   ╚███╔╝ ██║   ██║██║   ██║██╔██╗ ██║ ██║   ██║███████║██║  ███╗
--   ██╔██╗ ██║   ██║██║   ██║██║╚██╗██║ ██║   ██║██╔══██║██║   ██║
--  ██╔╝ ██╗╚██████╔╝╚██████╔╝██║ ╚████║ ╚██████╔╝██║  ██║╚██████╔╝
--  ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝
--
--  A simple starting point for XMonad.
--  Features:
--    - BSP Layout (like bspwm)
--    - Three Column Layout (like i3)
--    - Gaps and smart borders
--    - Integration with xmobar
--

-- ###################################################################
-- ##                          IMPORTS                              ##
-- ###################################################################

import XMonad

-- Core utilities
import XMonad.Util.Run (spawnPipe, hPutStrLn)
import XMonad.Util.EZConfig (additionalKeysP) -- For easier keybinding syntax "M-S-c"

-- Hooks for managing windows and bars
import XMonad.Hooks.ManageDocks (docks, manageDocks, avoidStruts)
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, shorten, PP(..))

-- Layouts
import XMonad.Layout.BinarySpacePartition (emptyBSP) -- The bspwm-like layout
import XMonad.Layout.ThreeColumns (ThreeColMid(..))  -- The i3-like column layout

-- Layout modifiers
import XMonad.Layout.Spacing (spacingRaw, Border(..)) -- For gaps
import XMonad.Layout.NoBorders (smartBorders)         -- Hide borders on single windows

-- For talking to xmobar
import System.IO (hPutStrLn)


-- ###################################################################
-- ##                         VARIABLES                             ##
-- ###################################################################

myModMask :: KeyMask
myModMask = mod4Mask -- Use the Super/Windows key as the mod key

myTerminal :: String
myTerminal = "alacritty" -- Or "st", "kitty", etc.

myBorderWidth :: Dimension
myBorderWidth = 2 -- Border width in pixels

myNormalBorderColor :: String
myNormalBorderColor = "#282a36" -- Color for unfocused windows

myFocusedBorderColor :: String
myFocusedBorderColor = "#bd93f9" -- Color for the focused window

-- Note: To use icons, you need a "Nerd Font" installed.
myWorkspaces :: [String]
myWorkspaces = ["  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "]


-- ###################################################################
-- ##                        KEYBINDINGS                            ##
-- ###################################################################
-- Using EZConfig syntax (e.g., "M-S-c" for Mod+Shift+c)

myKeys :: [(String, X ())]
myKeys =
    -- Launch a terminal
    [ ("M-S-<Return>", spawn myTerminal)

    -- Launch dmenu (application launcher)
    , ("M-p", spawn "dmenu_run -p 'Run: '")

    -- Close the focused window
    , ("M-S-c", kill)

    -- Rotate through the available layout algorithms
    , ("M-<Space>", sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ("M-S-<Space>", setLayout $ XMonad.layoutHook conf)

    -- Move focus to the next/previous window
    , ("M-j", windows $ W.focusDown)
    , ("M-k", windows $ W.focusUp)

    -- Swap the focused window with the master window
    , ("M-<Return>", windows $ W.swapMaster)

    -- Swap the focused window with the next/previous window
    , ("M-S-j", windows $ W.swapDown)
    , ("M-S-k", windows $ W.swapUp)

    -- Shrink/Expand the master area
    , ("M-h", sendMessage Shrink)
    , ("M-l", sendMessage Expand)

    -- Restart xmonad
    , ("M-q", spawn "xmonad --recompile && xmonad --restart")
    ]
    where
        -- Get the default config for the keybinding context
        conf = def { layoutHook = myLayoutHook }


-- ###################################################################
-- ##                           LAYOUTS                             ##
-- ###################################################################
-- Here we define our layouts and apply modifiers like gaps.

myLayoutHook = avoidStruts $ smartBorders $ myLayouts
  where
    -- Define the layouts we want to use
    myLayouts = bsp ||| tall ||| threeCol ||| Full

    -- Add gaps to a layout.
    -- The first three numbers are: top, right, bottom, left gaps.
    -- The fourth is window-to-window gap.
    gaps = spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True

    -- Define each layout with gaps
    bsp      = gaps $ emptyBSP
    tall     = gaps $ Tall 1 (3/100) (1/2) -- One master window, increments by 3%, 50% screen size
    threeCol = gaps $ ThreeColMid 1 (3/100) (1/2) -- i3-style three columns


-- ###################################################################
-- ##                      MANAGE HOOK                              ##
-- ###################################################################
-- This is where you tell XMonad how to handle certain windows.
-- `manageDocks` is for making it play nice with xmobar.

myManageHook = manageDocks <+> composeAll
    [ className =? "Gimp" --> doFloat
    , className =? "mpv"  --> doFloat
    ]


-- ###################################################################
-- ##                           MAIN                                ##
-- ###################################################################
-- This is where everything is tied together.

main :: IO ()
main = do
    -- Spawn xmobar and get a handle to it
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"

    -- The main xmonad configuration
    xmonad $ docks $ def
        {
          -- General settings
          terminal           = myTerminal
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor

          -- Hooks
        , layoutHook         = myLayoutHook
        , manageHook         = myManageHook

          -- This is what sends information to xmobar
        , logHook            = dynamicLogWithPP $ xmobarPP
              { ppOutput          = hPutStrLn xmproc
              , ppCurrent         = xmobarColor "#f8f8f2" "#50fa7b" . pad -- Focused workspace
              , ppVisible         = xmobarColor "#f8f8f2" "#6272a4" . pad -- Visible on other screen
              , ppHidden          = xmobarColor "#bd93f9" "" . pad         -- Hidden workspace with windows
              , ppHiddenNoWindows = xmobarColor "#6272a4" "" . pad         -- Hidden empty workspace
              , ppTitle           = xmobarColor "#f8f8f2" "" . shorten 60  -- Title of focused window
              , ppSep             = " | "
              , ppWsSep           = " "
              }
        }
        `additionalKeysP` myKeys