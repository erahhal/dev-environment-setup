import qualified Config
import qualified XMonad
import qualified XMonad.Layout.Gaps as Gaps
import qualified XMonad.Layout.PerScreen as PerScreen

conf = Config.myDefaultConf {
      XMonad.borderWidth = 1
    , XMonad.layoutHook = PerScreen.ifWider 1920 (Gaps.gaps [(Gaps.U, 24)] $ Config.myLayoutHook) (Gaps.gaps [(Gaps.U, 0)] $ Config.myLayoutHook)
    }

main = do
  XMonad.xmonad $ conf
