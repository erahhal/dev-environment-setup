import Config
import XMonad
import XMonad.Layout.Gaps
import XMonad.Layout.PerScreen

conf = myDefaultConf {
      borderWidth = 1
    , layoutHook = gaps [(U, 24)] $ myLayoutHook
    }

main = do
  xmonad $ conf
