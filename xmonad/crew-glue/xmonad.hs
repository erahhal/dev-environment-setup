import Config
import XMonad
import XMonad.Layout.Gaps
import XMonad.Layout.PerScreen

conf = myDefaultConf {
      borderWidth = 1
    , layoutHook = ifWider 1920 (gaps [(U, 24)] $ myLayoutHook) (gaps [(U, 0)] $ myLayoutHook)
    }

main = do
  xmonad $ conf
