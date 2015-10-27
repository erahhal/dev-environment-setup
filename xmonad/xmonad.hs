import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Layout.IndependentScreens
import System.IO

myManagementHooks :: [ManageHook]
myManagementHooks = [
  resource =? "stalonetray"    --> doIgnore
  , className =? "Gimp"        --> doFloat
  , className =? "Vncviewer"   --> doFloat
  ]

myWorkspaces = withScreens 2 ["1","2","3","4","5","6","7","8","9"]

myKeys xmproc = [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
         , ((0, xK_F3), spawn "sleep 0.2; scrot -s")
         , ((0, xK_F4), spawn "scrot")] ++
         [
         -- workspaces are distinct by screen
          ((m .|. mod1Mask, k), windows $ onCurrentScreen f i)
               | (i, k) <- zip (workspaces' (conf xmproc)) [xK_1 .. xK_9]
               , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]

conf xmproc = defaultConfig { 
    modMask = mod1Mask     -- default mod key is left alt
    , workspaces = myWorkspaces
    , manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll myManagementHooks
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , startupHook = do
        spawn "stalonetray"
        spawn "nm-applet"
        spawn "quicksynergy"
        spawn "caffeine"
        spawn "davmail"
        spawn "pidgin"
        -- spawn "google-chrome"
        -- spawn "gnome-terminal"
        -- spawn "skype"
    , logHook = dynamicLogWithPP xmobarPP
                            { ppOutput = hPutStrLn xmproc
                            , ppTitle = xmobarColor "green" "" . shorten 50
                            }
    , focusFollowsMouse = False
    , clickJustFocuses = False
    , borderWidth = 2
    } `additionalKeys` (myKeys xmproc)

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"
  xmonad $ conf xmproc
