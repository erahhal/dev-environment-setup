-- General terms
--
-- Monoid: Associative binary operations with an identity.  e.g. (1 + 2) + 3 = (3 + 1) + 2 (associativity)
--        3 + 0 = 3 (identity, which is 0)

-- Module definition
-- 1. name of module begins with capital letter
-- 2. file contains only one module
-- "where" introduces new scope
module Config where

-- Module imports
-- * "qualified" forces namespace, can't use bare definitions in module without module name
-- * "as" provides an alias for the module
import XMonad
-- XMonad provided operators
--  -->
--  <||>
--  <&&>
--  <+>
--  =?
import qualified XMonad.Config.Gnome as Gnome
import qualified XMonad.Actions.PhysicalScreens as PhysicalScreens
import qualified XMonad.Layout.NoBorders as NoBorders
import qualified XMonad.Hooks.ManageHelpers as ManageHelpers
import qualified XMonad.Hooks.EwmhDesktops as EmwhDesktops
import qualified XMonad.Hooks.ManageDocks as ManageDocks
import qualified XMonad.Hooks.ServerMode as ServerMode
import qualified XMonad.Hooks.SetWMName as SetWMName
import qualified XMonad.StackSet as StackSet
import qualified XMonad.Util.EZConfig as EZConfig
import qualified XMonad.Layout.IndependentScreens as IndependentScreens
import qualified Data.List as List
import qualified Data.Bits as Bits

myModMask = XMonad.mod4Mask

-- composeAll (XMonad) - compose a list of ManageHooks
gnomeManageHook = XMonad.composeAll [ XMonad.manageHook Gnome.gnomeConfig ]

-- :: can be read as "has type".  Optional since Haskell has type inference
myManagementHooks :: [XMonad.ManageHook]
myManagementHooks = [ gnomeManageHook ]

-- must run in a bash context to utilize $PATH
-- font of 15 is about the same size as the panel
myLauncher = "/bin/bash -c \"$(yeganesh -x -- -fn 'DroidSansMono Nerd Font-15' -p 'CHOOSE YOUR POISON \57521\57521')\""

-- "do" notation is shorthand for stringing together monads, in this case an IO monad
myStartupHook = do
        SetWMName.setWMName "LG3D"
        XMonad.spawn "/usr/bin/synergys -f --config ~/synergy.conf"
        -- spawn "ibus-daemon --xim --daemonize --desktop=xmonad --replace"

-- withScreens <number of screens> <list of workspace names>
myWorkspaces = IndependentScreens.withScreens 2 ["1","2","3","4","5","6","7","8","9"]

-- .|. is the bitwise OR operator
-- ( a, b) is a tuple constructor
-- (<modifier>, <key>), where 0 for <modifier> means no modifier
-- XMonad.mod1Mask = Alt
-- XMonad.mod4Mask = Super
-- "spawn" executes a command
-- ++ concatenates two lists
-- <- is variable assignment
-- [ x | x <- l, p x ] is list comprehension
-- .. is range (inclusive)
-- $ is for grouping, a synonym for parens
myKeys = [ ((myModMask Bits..|. XMonad.shiftMask, XMonad.xK_z), XMonad.spawn "xscreensaver-command -lock")
         , ((0, XMonad.xK_F3), XMonad.spawn "sleep 0.2; scrot -s")
         , ((0, XMonad.xK_F4), XMonad.spawn "scrot")
         -- Media Keys
         , ((0, XMonad.xK_F8  ), XMonad.spawn "amixer set Master toggle; amixer set Headphone toggle") -- XF86AudioMute
         , ((0, XMonad.xK_F9  ), XMonad.spawn "amixer set Master 5%-") -- XF86AudioLowerVolume
         , ((0, XMonad.xK_F10 ), XMonad.spawn "amixer set Master 5%+") -- XF86AudioRaiseVolume
         -- Spawn the launcher using command specified by myLauncher.
         -- Use this to launch programs without a key binding.
         , ((myModMask, XMonad.xK_p), XMonad.spawn myLauncher)
         , ((XMonad.mod1Mask, XMonad.xK_Tab), windows StackSet.focusDown)
         ] ++
         [
         -- workspaces are distinct per physical screen
         -- a "windowSet" is a set of windows per virtual screen
         -- onCurrentScreen takes a function that operates on a virtual workspace and window set and returns a function that
         --     operates on a physical workspace and window set
         -- $ avoids parantheses - gives precendence to function on the right
         -- . chains functions
         --     see: https://stackoverflow.com/questions/940382/what-is-the-difference-between-dot-and-dollar-sign
         -- StackSet.view switches to screen
         -- StackSet.shift moves content to another screen
         --
         -- This is a list comprehension that takes each windowSet (set of windows per virtual screen), and maps a view and shift key binding
         -- that operates on the appropriate physical screen
          ((modifierKey Bits..|. myModMask, numberKey), XMonad.windows $ IndependentScreens.onCurrentScreen screenOperation windowSet)
               | (windowSet, numberKey) <- zip (IndependentScreens.workspaces' myDefaultConf) [XMonad.xK_1 .. XMonad.xK_9]
               , (screenOperation, modifierKey) <- [(StackSet.view, 0), (StackSet.shift, XMonad.shiftMask)]
         ] ++
         [
         -- make sure screens are ordered by physical location rather than screen ID, as screen ID is unpredictable
          -- ((modifierKey Bits..|. myModMask, physicalScreenKey), screenOperation screenCount)
          --    | (physicalScreenKey, screenCount) <- zip [XMonad.xK_w, XMonad.xK_e, XMonad.xK_r] [0..]
          --    , (screenOperation, modifierKey) <- [(PhysicalScreens.viewScreen, 0), (PhysicalScreens.sendToScreen, XMonad.shiftMask)]
         ]

-- Can get things from xprop using stringProperty "WM_NAME", or the like
-- q =? x
--      "if the result of q equals x, return True"
-- <&&>
--      Boolean "and" lifted to a Monad
-- <||>
--      Boolean "or" lifted to a Monad
-- foldr1
--      takes the last two items of the list and applies the function, then it takes the third item from the end and the result, and so on
-- -->
--
-- `<function>`
--      Makes function an infix operator
-- fmap
--     functor map - basic map function
-- List.isInfixOf
--     If list is a sublist of another list.  In this case, it's a substring check
floatManageHooks = XMonad.composeAll [isFloat --> XMonad.doFloat] where
    isFloat = foldr1 (<||>) [
          XMonad.className =? "Do"
        , XMonad.className =? "Toplevel"
        , XMonad.className =? "vlc"
        , XMonad.className =? "mpv"
        , fmap ("ardour" `List.isInfixOf`) XMonad.className
        , fmap ("Ardour" `List.isInfixOf`) XMonad.className
        , XMonad.className =? "Xpra-Launcher"
        , XMonad.className =? "qsynth"
        , XMonad.className =? "qjackctl"
        , XMonad.className =? "Qjackctl"
        , XMonad.className =? "Gnome-calculator"
        , XMonad.className =? "Vncviewer"
        , XMonad.className =? "Zenity" <&&> (XMonad.title =? "Log Out" <||> XMonad.title =? "Restart" <||> XMonad.title =? "Shut Down")
        , XMonad.className =? "FireFox" <&&> (XMonad.resource =? "Browser" <||> XMonad.resource =? "Toplevel")
        , XMonad.className =? "Pidgin" <&&>
            (XMonad.title =? "Accounts" <||> XMonad.title =? "System Log" <||> XMonad.title =? "Plugins" <||>
            XMonad.title =? "Room List" <||> XMonad.title =? "Custom Smiley Manager" <||>
            XMonad.title =? "File Transfers"  <||> XMonad.title =? "Buddy Information")
        , XMonad.title =? "Graphical Representations"
      ]

myLayoutHook = ManageDocks.avoidStruts $ NoBorders.smartBorders $ XMonad.layoutHook XMonad.def

myDefaultConf = EmwhDesktops.ewmh XMonad.def {
      XMonad.modMask = myModMask
    , XMonad.terminal = "gnome-terminal"
    , XMonad.workspaces = myWorkspaces
    , XMonad.handleEventHook = ServerMode.serverModeEventHook <+> XMonad.handleEventHook XMonad.def <+> EmwhDesktops.fullscreenEventHook
    , XMonad.manageHook = floatManageHooks <+> ManageDocks.manageDocks <+> (ManageHelpers.isFullscreen --> ManageHelpers.doFullFloat) <+> XMonad.manageHook XMonad.def <+> XMonad.composeAll myManagementHooks
    , XMonad.startupHook = XMonad.startupHook Gnome.gnomeConfig >> myStartupHook
    , XMonad.focusFollowsMouse = False
    , XMonad.clickJustFocuses = False
    , XMonad.focusedBorderColor = "#FFFF00"
    } `EZConfig.additionalKeys` (myKeys)
