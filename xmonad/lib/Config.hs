module Config where

import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.PhysicalScreens
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Layout.IndependentScreens

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
               | (i, k) <- zip (workspaces' (myDefaultConf)) [xK_1 .. xK_9]
               , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ] ++
         [
         -- make sure screens are ordered by physical location rather than screen ID
          ((m .|. mod1Mask, k), f sc)
             | (k, sc) <- zip [xK_w, xK_e, xK_r] [0..]
             , (f, m) <- [(viewScreen, 0), (sendToScreen, shiftMask)]
         ]

floatManageHooks = composeAll [isFloat --> doFloat] where
    isFloat = foldr1 (<||>) [isDo, isEdge, isVlc, isMpv, isXpra, isQjackctl, isVncviewer, isGnomeSystemAction, isFirefoxDialog, isPidginDialog, isVMDdialog] where
        isDo   = className =? "Do"
        isEdge = className =? "Toplevel"
        isVlc = className =? "vlc"
        isMpv = className =? "mpv"
        isXpra = className =? "Xpra-Launcher"
        isQjackctl = className =? "qjackctl"
        isVncviewer = className =? "Vncviewer"
        isGnomeSystemAction  = className =? "Zenity" <&&> (title =? "Log Out" <||> title =? "Restart" <||> title =? "Shut Down")
        isFirefoxDialog = className =? "FireFox" <&&> (resource =? "Browser" <||> resource =? "Toplevel")
        isPidginDialog  = className =? "Pidgin" <&&> foldr1 (<||>) [
            title =? "Accounts", title =? "System Log", title =? "Plugins",
            title =? "Room List", title =? "Custom Smiley Manager",
            title =? "File Transfers", title =? "Buddy Information"]
        isVMDdialog = title =? "Graphical Representations"

myLayoutHook = avoidStruts $ smartBorders $ layoutHook def

myDefaultConf = ewmh def {
      modMask = mod1Mask     -- default mod key is left alt
    , terminal = "gnome-terminal"
    , workspaces = myWorkspaces
    , handleEventHook = handleEventHook def <+> fullscreenEventHook
    , manageHook = floatManageHooks <+> manageDocks <+> (isFullscreen --> doFullFloat) <+> manageHook def <+> composeAll myManagementHooks
    , startupHook = startupHook gnomeConfig >> myStartupHook
    , focusFollowsMouse = False
    , clickJustFocuses = False
    , focusedBorderColor = "#FFFF00"
    } `additionalKeys` (myKeys)
