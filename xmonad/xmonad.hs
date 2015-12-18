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
  ]

myLauncher = "$(yeganesh -x -- -fn '-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*' -nb '#000000' -nf '#FFFFFF' -sb '#7C7C7C' -sf '#CEFFAC')"

myWorkspaces = withScreens 2 ["1","2","3","4","5","6","7","8","9"]
 
myKeys xmproc = [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
         , ((0, xK_F3), spawn "sleep 0.2; scrot -s")
         , ((0, xK_F4), spawn "scrot")
         -- Media Keys
         , ((0, 0x1008ff12  ), spawn "vol mute") -- XF86AudioMute
         , ((0, 0x1008ff11  ), spawn "vol down") -- XF86AudioLowerVolume
         , ((0, 0x1008ff13  ), spawn "vol up") -- XF86AudioRaiseVolume
         -- Spawn the launcher using command specified by myLauncher.
         -- Use this to launch programs without a key binding.
         , ((mod1Mask, xK_p), spawn myLauncher)
         ] ++
         [
         -- workspaces are distinct by screen
          ((m .|. mod1Mask, k), windows $ onCurrentScreen f i)
               | (i, k) <- zip (workspaces' (conf xmproc)) [xK_1 .. xK_9]
               , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]

floatManageHooks = composeAll [isFloat --> doFloat] where
    isFloat = foldr1 (<||>) [isDo, isGimp, isVncviewer, isFirefoxDialog, isPidginDialog, isVMDdialog] where
        isDo   = className =? "Do"
        isGimp = className =? "Gimp"
        isVncviewer = className =? "Vncviewer"
        isFirefoxDialog = className =? "FireFox" <&&> (resource =? "Browser" <||> resource =? "Toplevel")
        isPidginDialog  = className =? "Pidgin" <&&> foldr1 (<||>) [
            title =? "Accounts", title =? "System Log", title =? "Plugins",
            title =? "Room List", title =? "Custom Smiley Manager",
            title =? "File Transfers", title =? "Buddy Information"]
        isVMDdialog = title =? "Graphical Representations"

conf xmproc = defaultConfig { 
    modMask = mod1Mask     -- default mod key is left alt
    , workspaces = myWorkspaces
    , manageHook = floatManageHooks <+> manageDocks <+> manageHook defaultConfig <+> composeAll myManagementHooks
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , startupHook = do
        spawn "stalonetray"
        spawn "nm-applet"
        spawn "blueman-applet"
        spawn "quicksynergy"
        spawn "caffeine"
        spawn "pidgin"
        -- spawn "davmail"
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
  -- the x argument tells xmobar which screen to run on
  -- xmproc <- spawnPipe "/usr/bin/xmobar -x ~/.xmonad/xmobarrc"
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobarrc"
  xmonad $ conf xmproc
