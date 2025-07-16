-- ~/.xmonad/xmonad.hs

-- | Imports | --
import XMonad
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W
import Data.Default (def)
import System.IO (hPutStrLn)
import XMonad.Util.Run (spawnPipe)

-- Utilities
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad

-- Hooks
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.DynamicLog

-- Layouts
import XMonad.Layout.Renamed
import XMonad.Layout.NoBorders (smartBorders, noBorders)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Layout.Tabbed
import XMonad.Layout.MultiToggle (mkToggle, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR))

-- Actions
import XMonad.Actions.CycleWS (nextScreen, prevScreen)
import XMonad.Actions.PhysicalScreens (viewScreen, PhysicalScreen(..))

-- For Volume/Brightness keys
import Graphics.X11.ExtraTypes.XF86

-- | Variables | --
myModMask       = mod4Mask
myTerminal      = "kitty"
myBorderWidth   = 2

myWorkspaces :: [String]
myWorkspaces = map show [1..10]

-- Tokyo Night Theme
myBackground      = "#1a1b26"
myForeground      = "#c0caf5"
myUnfocusedBorder = "#1f2335"
myInactiveText    = "#5c6370"
myFocusedBorder   = "#7aa2f7"
myUrgentBorder    = "#f7768e"

-- Tabbed Theme
myTabTheme = def
    { fontName              = "xft:DejaVu Sans Mono:size=11"
    , activeColor           = myFocusedBorder
    , inactiveColor         = myBackground
    , activeBorderColor     = myFocusedBorder
    , inactiveBorderColor   = myBackground
    , activeTextColor       = myBackground
    , inactiveTextColor     = myInactiveText
    }

-- | Layouts | --
myLayout = smartBorders . mkToggle (NBFULL ?? EOT) $ myLayouts

myLayouts =
       renamed [Replace "Tall"] tiled
    ||| renamed [Replace "Mirror Tall"] (Mirror tiled)
    ||| renamed [Replace "Tabbed"] (avoidStruts $ noBorders $ tabbed shrinkText myTabTheme)
    ||| renamed [Replace "Full"] Full
  where
    tiled = Tall 1 (3/100) (1/2)

-- | Scratchpads | --
myScratchpads =
    [ NS "terminal" "kitty --name scratchpad"
        (resource =? "scratchpad")
        (customFloating $ W.RationalRect (1/4) (1/4) (1/2) (1/2))
    ]

-- | ManageHook | --
myManageHook = composeAll
    [ manageHook def
    , isFullscreen --> doFullFloat
    , className =? "mpv" --> doShift (myWorkspaces !! 3)
    , namedScratchpadManageHook myScratchpads
    ]

-- | Keybindings | --
myKeys =
    [ ("M-S-<Return>", spawn "rofi -show combi")
    , ("M-d", spawn "dmenu_run")
    , ("M-<Return>", spawn myTerminal)
    , ("M-S-f", spawn "nemo")
    , ("M-t", spawn "flatpak run io.github.kukuruzka165.materialgram")
    , ("M-p", spawn "sh ~/.config/mpv/pause")
    , ("M-q", kill)
    , ("M-f", sendMessage $ Toggle NBFULL)
    , ("M-S-<Space>", withFocused $ windows . W.sink)

    -- Layout Switching
    , ("M-w", sendMessage $ JumpToLayout "Tabbed")
    , ("M-z", sendMessage $ JumpToLayout "Tall")
    , ("M-v", sendMessage $ JumpToLayout "Mirror Tall")
    , ("M-x", sendMessage $ JumpToLayout "Full")

    -- Resize
    , ("M-h", sendMessage Shrink)
    , ("M-l", sendMessage Expand)

    -- Focus
    , ("M-j", windows W.focusDown)
    , ("M-k", windows W.focusUp)
    , ("M-a", windows W.focusMaster)
    , ("M-<Tab>", windows W.focusDown)

    -- Move
    , ("M-S-j", windows W.swapDown)
    , ("M-S-k", windows W.swapUp)

    -- Scratchpad
    , ("M-n", namedScratchpadAction myScratchpads "terminal")
    , ("M-S-n", namedScratchpadAction myScratchpads "terminal")

    -- System Controls
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +10%")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 10%-")
    , ("<Print>", spawn "maim -s -u | tee \"$HOME/screenshots/$(date +%s).png\" | xclip -selection clipboard -t image/png")

    -- XMonad
    , ("M-S-q", io exitSuccess)
    , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
    ] ++
    [ ("M-" ++ key, viewScreen def sc)
      | (key, sc) <- zip ["w", "r"] [P 0, P 1]
    ]

-- | Startup | --
myStartupHook = do
    spawnOnce "dex --autostart --environment i3"
    spawnOnce "xbindkeys"
    spawnOnce "xss-lock --transfer-sleep-lock -- i3lock --nofork"
    spawnOnce "xinput set-prop 14 \"libinput Tapping Enabled\" 1"

-- | Main | --
main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ ewmh $ def
        { modMask            = myModMask
        , terminal           = myTerminal
        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , startupHook        = myStartupHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myUnfocusedBorder
        , focusedBorderColor = myFocusedBorder
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppCurrent = xmobarColor "#f7768e" "" . wrap "[" "]"
            , ppTitle   = xmobarColor "#7aa2f7" "" . shorten 50
            , ppSep     = " | "
            }
        } `additionalKeysP` myKeys
