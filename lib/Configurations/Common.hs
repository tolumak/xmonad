{-# LANGUAGE FlexibleContexts #-}

module Configurations.Common
where

import System.IO
import System.Process
import System.Exit
import XMonad
import XMonad.Config.Azerty
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.DynamicLog
import XMonad.Actions.CopyWindow
import XMonad.Layout.Tabbed
import XMonad.Layout.BorderResize
import XMonad.Layout.SimpleFloat
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import Network.BSD
import qualified XMonad.StackSet as W

-- use xprop on the window
-- See documentation of XMonad.ManageHook
-- appName = first string of WM_CLASS
-- className = second string of WM_CLASS
-- resource = same as appName
commonManageHook = composeAll
    [ 
    className =? "Vncviewer" --> doFloat
    , className =? "firefox" --> doShift "2"
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat
    , className =? "Kmail" --> doShift "3"
    , className =? "Lanikai" --> doShift "3"
    , className =? "Thunderbird" --> doShift "3"
    , appName =? "Mail" --> doShift "3"
    , appName =? "Alert" --> doFloat
    , (className =? "Pidgin" <&&> title =? "mouches") --> doShift "1"
    , appName =? "emacs" --> doShift "1"
    , (appName =? "emacs" <&&> resource =? "Dialog") --> doFloat
    ]

    

commonKeys conf@(XConfig {XMonad.modMask = modm}) =
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
             , ((modm .|. shiftMask, xK_q    ),  io (defaultAutostop) >> io (exitWith ExitSuccess) ) -- Close xmonad
             ]
-- All (too many) layout
--myLayout = tiled ||| Mirror tiled ||| Full ||| simpleTabbed ||| borderResize ( simpleFloat )

-- Just a limited set of layout
layoutTiledBigMaster = tiled ||| noBorders simpleTabbed ||| Mirror tiled
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 4/5 

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

layoutTabbed = noBorders simpleTabbed ||| tiled ||| Mirror tiled
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

layoutTiled = tiled ||| Mirror tiled ||| noBorders simpleTabbed
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100


makeConfig newManageHook newLayoutHook newKeys newModMask = ewmh $ azertyConfig
         { modMask = newModMask  -- Rebing Mod to the Windows key
         , terminal = "urxvt -si -sw -sk -sl 65535 -tr -sh 25 -fn 'xft:DejaVu Sans Mono:size=9:antialias=on' -rv"
         , borderWidth        = 3
         , focusedBorderColor = "#FF0000"
         , manageHook = manageDocks <+> commonManageHook <+> newManageHook
                         <+> manageHook def
         , layoutHook = avoidStruts
                        $ newLayoutHook
         , keys = newKeys
         }

xmobarSpawn :: String -> String
xmobarSpawn xmobarrc = "/usr/bin/xmobar " ++ xmobarrc

defaultXMobarrc host = "~/.xmonad/xmobarrc-" ++ host
defaultAutostart host = "/bin/sh ~/.xmonad/autostart-" ++ host ++ ".sh"
defaultAutostop = do
  hostStr <- getHostName
  let str = "/bin/sh ~/.xmonad/autostop-" ++ hostStr ++ ".sh"
  spawn str

myPP = xmobarPP { ppCurrent = xmobarColor "green" "" . shorten 50 }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

xmonadStart config = do
            host <- getHostName
            spawn (defaultAutostart host)
            xmonad =<< statusBar (xmobarSpawn (defaultXMobarrc host)) myPP toggleStrutsKey config    
