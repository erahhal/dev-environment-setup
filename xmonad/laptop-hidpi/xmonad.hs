import Config
import XMonad
import XMonad.Layout.Gaps
import XMonad.Layout.PerScreen

conf = myDefaultConf {
      borderWidth = 3
    , layoutHook = gaps [(U, 48)] $ myLayoutHook
    }

main = do
  xmonad $ conf
