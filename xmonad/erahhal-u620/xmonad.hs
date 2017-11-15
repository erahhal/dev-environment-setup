import Config
import XMonad
import XMonad.Layout.Gaps

conf = myDefaultConf {
      borderWidth = 1
    , layoutHook = gaps [(U, 24)] $ myLayoutHook
    }

main = do
  xmonad $ conf
