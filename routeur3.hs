import XMonad
import XMonad.Config.Azerty
import XMonad.ManageHook
import XMonad.Layout.PerWorkspace
import Configurations.Common
import qualified Data.Map as M

newManageHook = composeAll [
    className =? "Digikam" --> doShift "4", 
    className =? "Darktable" --> doShift "4", 
    resource =? "stalonetray" --> doIgnore
    ]

newLayoutHook = onWorkspace "1" layoutTiledBigMaster
                $ onWorkspaces ["2", "3", "4"] layoutTabbed
                $ layoutTiled


newKeys x = M.union (M.fromList (commonKeys x)) (keys azertyConfig x)


main = xmonadStart (makeConfig newManageHook newLayoutHook newKeys mod1Mask)
