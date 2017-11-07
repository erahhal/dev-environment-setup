import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.Minimize
import qualified Data.Map as M
import System.Exit -- exitWith
import XMonad.Layout.Gaps
import XMonad.Layout.PerScreen
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Layout.IndependentScreens
import Control.Monad
import Data.Monoid (All (All))
import System.IO

unityManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-launcher" --> doIgnore
    ])

myManagementHooks :: [ManageHook]
myManagementHooks = [
    unityManageHook
  ]

myLauncher = "$(yeganesh -x -- -fn '-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*' -nb '#000000' -nf '#FFFFFF' -sb '#7C7C7C' -sf '#CEFFAC')"

myStartupHook = do
        setWMName "LG3D"
        spawn "caffeine-indicator"
        -- redshift should be launched automatically by gnome
        -- spawn "redshift-gtk"
        spawn "/usr/bin/synergys -f --config ~/synergy.conf"

myWorkspaces = withScreens 2 ["1","2","3","4","5","6","7","8","9"]

myKeys = [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
         , ((0, xK_F3), spawn "sleep 0.2; scrot -s")
         , ((0, xK_F4), spawn "scrot")
         -- Media Keys
         , ((0, xK_F8  ), spawn "amixer set Master toggle; amixer set Headphone toggle") -- XF86AudioMute
         , ((0, xK_F9  ), spawn "amixer set Master 5%-") -- XF86AudioLowerVolume
         , ((0, xK_F10 ), spawn "amixer set Master 5%+") -- XF86AudioRaiseVolume
         -- Spawn the launcher using command specified by myLauncher.
         -- Use this to launch programs without a key binding.
         , ((mod1Mask, xK_p), spawn myLauncher)
         ] ++
         [
         -- workspaces are distinct by screen
          ((m .|. mod1Mask, k), windows $ onCurrentScreen f i)
               | (i, k) <- zip (workspaces' (conf)) [xK_1 .. xK_9]
               , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]

floatManageHooks = composeAll [isFloat --> doFloat] where
    isFloat = foldr1 (<||>) [isDo, isEdge, isVlc, isMpv, isVncviewer, isGnomeSystemAction, isFirefoxDialog, isPidginDialog, isVMDdialog] where
        isDo   = className =? "Do"
        isEdge = className =? "Toplevel"
        isVlc = className =? "vlc"
        isMpv = className =? "mpv"
        isVncviewer = className =? "Vncviewer"
        isGnomeSystemAction  = className =? "Zenity" <&&> (title =? "Log Out" <||> title =? "Restart" <||> title =? "Shut Down")
        isFirefoxDialog = className =? "FireFox" <&&> (resource =? "Browser" <||> resource =? "Toplevel")
        isPidginDialog  = className =? "Pidgin" <&&> foldr1 (<||>) [
            title =? "Accounts", title =? "System Log", title =? "Plugins",
            title =? "Room List", title =? "Custom Smiley Manager",
            title =? "File Transfers", title =? "Buddy Information"]
        isVMDdialog = title =? "Graphical Representations"

myLayoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig

conf = ewmh defaultConfig {
      modMask = mod1Mask     -- default mod key is left alt
    , terminal = "gnome-terminal"
    , workspaces = myWorkspaces
    , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
    , manageHook = floatManageHooks <+> manageDocks <+> (isFullscreen --> doFullFloat) <+> manageHook defaultConfig <+> composeAll myManagementHooks
    , layoutHook = ifWider 1920 (gaps [(U, 24)] $ myLayoutHook) (gaps [(U, 0)] $ myLayoutHook)
    , startupHook = startupHook gnomeConfig >> myStartupHook
    , focusFollowsMouse = False
    , clickJustFocuses = False
    , focusedBorderColor = "#FFFF00"
    , borderWidth = 1
    } `additionalKeys` (myKeys)

main = do
  xmonad $ conf
