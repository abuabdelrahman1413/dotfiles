import XMonad
-- NOTE: Only needed for versions < 0.18.0! For 0.18.0 and up, this is
-- already included in the XMonad import and will give you a warning!
import XMonad.Util.EZConfig (additionalKeysP)
main :: IO ()
main = xmonad $ def
    { modMask = mod4Mask  -- Rebind Mod to the Super key
    }
