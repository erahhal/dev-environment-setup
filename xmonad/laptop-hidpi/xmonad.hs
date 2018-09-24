import qualified Config
import qualified XMonad
import qualified XMonad.Layout.Gaps as Gaps
import qualified XMonad.Layout.PerScreen as PerScreen
import qualified XMonad.Layout.IndependentScreens as IndependentScreens

conf nScreens = Config.myDefaultConf {
      XMonad.borderWidth = 2
    , XMonad.layoutHook = PerScreen.ifWider 1920 (Gaps.gaps [(Gaps.U, 48)] $ Config.myLayoutHook) (if nScreens > 1 then Gaps.gaps [(Gaps.U, 0)] $ Config.myLayoutHook else Gaps.gaps [(Gaps.U, 48)] $ Config.myLayoutHook)
    }

main = do
  nScreens <- IndependentScreens.countScreens
  XMonad.xmonad $ conf nScreens
