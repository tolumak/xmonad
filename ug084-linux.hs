import XMonad
import XMonad.Config.Azerty
import XMonad.ManageHook
import XMonad.Layout.PerWorkspace
import XMonad.Hooks.ManageHelpers
import Configurations.Common
import qualified Data.Map as M

newManageHook = composeAll [
    className =? "Evolution" --> doShift "3",
    resource =? "stalonetray" --> doIgnore
    ] <+> composeOne [ isFullscreen -?> doFullFloat ]


newLayoutHook = onWorkspace "1" layoutTiledBigMaster
                $ onWorkspaces ["2", "3"] layoutTabbed
                $ layoutTiled


newKeys x = M.union (M.fromList (commonKeys x)) (keys azertyConfig x)


main = xmonadStart (makeConfig newManageHook newLayoutHook newKeys)
