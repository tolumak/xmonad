import XMonad
import XMonad.Config.Azerty
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CopyWindow
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Tabbed
import XMonad.Layout.BorderResize
import XMonad.Layout.SimpleFloat
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.IO
import System.Process

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "Firefox-bin" --> doShift "2"
    , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
    , className =? "kmail" --> doShift "3"
    , (className =? "Pidgin" <&&> name =? "mouches") --> doShift "1"
    , className =? "emacs" --> doShift "1"
    ]

newKeys x = M.union (M.fromList (myKeys x)) (keys azertyConfig x)

myKeys conf@ (XConfig {XMonad.modMask = modm}) =
             [
              -- mod-[1..9] @@ Switch to workspace N
              -- mod-shift-[1..9] @@ Move client to workspace N
              -- mod-control-shift-[1..9] @@ Copy client to workspace N
               ((m .|. modm, k), windows $ f i)
                 | (i, k) <- zip (XMonad.workspaces conf) [0x26,0xe9,0x22,0x27,0x28,0x2d,0xe8,0x5f,0xe7,0xe0]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask)]
             ]
             ++
             [
               ((modm .|. shiftMask, xK_c     ), kill1) -- @@ Close the focused window
	     , ((modm,               xK_j     ), windows W.focusUp  ) -- %! Move focus to the previous window
             , ((modm,               xK_k     ), windows W.focusDown) -- %! Move focus to the next window             
             , ((modm .|. shiftMask, xK_j     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window
             , ((modm .|. shiftMask, xK_k     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
	     , ((modm .|. shiftMask, xK_l    ), spawn "xlock") -- %! Lock the screen
             ]
-- All (too many) layout
--myLayout = tiled ||| Mirror tiled ||| Full ||| simpleTabbed ||| borderResize ( simpleFloat )

-- Just a limited set of layout
layoutW1 = tiled ||| simpleTabbed ||| Mirror tiled
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 4/5 

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

layoutFS = simpleTabbed ||| tiled ||| Mirror tiled
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

layoutOthers = tiled ||| Mirror tiled ||| simpleTabbed
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

main = do
     spawn "bash ~/.xmonad/autostart.sh"
     xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"
     xmonad $ azertyConfig
         { modMask = mod4Mask  -- Rebing Mod to the Windows key
         , terminal = "urxvt -fn 'xft:DejaVu Sans Mono:size=9:antialias=off' -rv"
	 , borderWidth        = 3	     
         , focusedBorderColor = "#FF0000"
         , manageHook = manageDocks <+> myManageHook
                         <+> manageHook defaultConfig
         , layoutHook = avoidStruts  
                        $ onWorkspace "1" layoutW1
                        $ onWorkspaces ["2", "3", "4"] layoutFS
                        $ layoutOthers
         , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }

         , keys = newKeys

         }
