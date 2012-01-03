module Configurations.Common
where

import System.IO
import System.Process
import XMonad
import XMonad.Config.Azerty
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.DynamicLog
import XMonad.Actions.CopyWindow
import XMonad.Layout.Tabbed
import XMonad.Layout.BorderResize
import XMonad.Layout.SimpleFloat
import XMonad.Hooks.ManageDocks
import Network.BSD
import qualified XMonad.StackSet as W

commonManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "Firefox" --> doShift "2"
    , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
    , className =? "Kmail" --> doShift "3"
    , className =? "Lanikai" --> doShift "3"
    , className =? "Thunderbird" --> doShift "3"
    , appName =? "Mail" --> doShift "3"
    , (className =? "Pidgin" <&&> title =? "mouches") --> doShift "1"
    , appName =? "emacs" --> doShift "1"
    , (appName =? "emacs" <&&> resource =? "Dialog") --> doFloat
    ]

commonKeys conf@ (XConfig {XMonad.modMask = modm}) =
             [
              -- mod-[1..9] @@ Switch to workspace N
              -- mod-shift-[1..9] @@ Move client to workspace N
              -- mod-control-shift-[1..9] @@ Copy client to workspace N
               ((m .|. modm, k), windows $ f i)
                 | (i, k) <- zip (XMonad.workspaces conf) [0x26,0xe9,0x22,0x27,0x28,0x2d,0xe8,0x5f,0xe7,0xe0]
                 , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask)]
             ]
             ++
             [
               ((modm .|. shiftMask, xK_c     ), kill1) -- @@ Close the focused window
	     , ((modm,               xK_j     ), windows W.focusUp  ) -- %! Move focus to the previous window
             , ((modm,               xK_k     ), windows W.focusDown) -- %! Move focus to the next window             
             , ((modm .|. shiftMask, xK_j     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window
             , ((modm .|. shiftMask, xK_k     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
	     , ((modm .|. shiftMask, xK_l    ), spawn "slock") -- %! Lock the screen
             , ((modm,               xK_p    ), spawn "dmenu_run") -- %! Menu
             ]
-- All (too many) layout
--myLayout = tiled ||| Mirror tiled ||| Full ||| simpleTabbed ||| borderResize ( simpleFloat )

-- Just a limited set of layout
layoutTiledBigMaster = tiled ||| simpleTabbed ||| Mirror tiled
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 4/5 

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

layoutTabbed = simpleTabbed ||| tiled ||| Mirror tiled
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

layoutTiled = tiled ||| Mirror tiled ||| simpleTabbed
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100


makeConfig newManageHook newLayoutHook newKeys = azertyConfig
         { modMask = mod4Mask  -- Rebing Mod to the Windows key
         , terminal = "urxvt -si -sw -sk -sl 65535 -tr -sh 25 -fn 'xft:DejaVu Sans Mono:size=9:antialias=on' -rv"
         , borderWidth        = 3
         , focusedBorderColor = "#FF0000"
         , manageHook = manageDocks <+> commonManageHook <+> newManageHook
                         <+> manageHook defaultConfig
         , layoutHook = avoidStruts
                        $ newLayoutHook
         , keys = newKeys
         }

xmobarSpawn :: String -> String
xmobarSpawn xmobarrc = "/usr/bin/xmobar " ++ xmobarrc

defaultXMobarrc host = "~/.xmonad/xmobarrc-" ++ host
defaultAutostart host = "/bin/sh ~/.xmonad/autostart-" ++ host ++ ".sh"

xmonadStart config = do
            host <- getHostName
            spawn (defaultAutostart host)
            xmproc <- spawnPipe (xmobarSpawn (defaultXMobarrc host))
            xmonad $ config {
                   logHook =dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
            }