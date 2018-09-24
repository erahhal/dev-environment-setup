import qualified Config
import qualified XMonad
import qualified XMonad.Layout.Gaps as Gaps

conf = Config.myDefaultConf {
      XMonad.borderWidth = 1
    , XMonad.layoutHook = Gaps.gaps [(Gaps.U, 24)] $ Config.myLayoutHook
    }

main = do
  XMonad.xmonad $ conf
