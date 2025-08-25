import XMonad
import Xmonad.Hooks.DynamicLog
import Xmonad.Hooks.ManageDocks
import Xmonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Ungrab
import XMonad.Actions.CopyWindow (kill1, killAllOtherCopies)
import XMonad.Actions.CycleWS (WSType (..), moveTo, nextScreen, prevScreen, shiftTo)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize

import Control.Arrow (first)
import Control.Monad
import Data.Char (isSpace)
import Data.Map qualified as M
import Data.Maybe (isJust)
import Data.Monoid
import Data.Tree
import System.Exit (exitSuccess)
import System.IO (hPutStrLn)

main :: IO ()
main = do

    xmproc <- spawnPipe "xmobar"

    xmonad $
        def { modMask = mod4Mask } -- rebind mod to superkey
        `additionalKeysP` [
            ("M-S-z", spawn "xscreensaver-command -lock")
            , ("M-C-s", unGrab *> spawn "scrot -s")
            , ("M-f", spawn "zen-browser")
        ]
        defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        , modMask = mod4Mask            -- Rebind mod to windows key
        }
        fullscreenSupport $
            withNavigation2DConfig def $
              ewmh
                def
                  {
                  -- <+> is a synonym for mappend, the Monoid operation.
                  -- xmonad predates the introduction of <>.
                  -- run xmonad commands with "xmonadctl command"
                    manageHook = (isFullscreen --> doFullFloat) <+>,
                  }

