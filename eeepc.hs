import XMonad
import XMonad.Config.Azerty
import XMonad.ManageHook
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Tabbed
import Configurations.Common
import qualified Data.Map as M

newManageHook = composeAll [
    resource =? "stalonetray" --> doIgnore
    ]

layoutTiledBimo = tiled ||| simpleTabbed ||| Mirror tiled
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 2
     ratio   = 3/5 
     delta   = 3/100

newLayoutHook = onWorkspace "1" layoutTiledBimo
                $ onWorkspaces ["2", "3"] layoutTabbed
                $ layoutTiled

newKeys x = M.union (M.fromList (commonKeys x)) (keys azertyConfig x)


main = xmonadStart (makeConfig newManageHook newLayoutHook newKeys mod4Mask)
