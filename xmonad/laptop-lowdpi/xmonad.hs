import qualified Config
import qualified XMonad
import qualified XMonad.Layout.Gaps as Gaps
import qualified XMonad.Layout.PerScreen as PerScreen

conf = Config.myDefaultConf {
      XMonad.borderWidth = 1
    , XMonad.layoutHook = Gaps.gaps [(Gaps.U, 24)] $ Config.myLayoutHook
    }

main = do
  XMonad.xmonad $ conf
