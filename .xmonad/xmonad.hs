import XMonad
import XMonad.Util.Cursor
import XMonad.Config.Desktop
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Util.SpawnOnce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run

import System.IO

baseConfig = desktopConfig

startup = do
  spawnOnce "feh --bg-fill ~/Desktop/wallpaper.jpg"
  spawnOnce "xrdb ~/.Xresources"
  spawnOnce "xmodmap ~/.Xmodmap"
  spawnOnce "compton -b --config ~/.config/compton/compton.conf &"
  setDefaultCursor xC_left_ptr

layout = spacing 10 $ gaps [(U, 34)] $ Tall 1 (3/100) (1/2)
loghook h = dynamicLogWithPP $ defaultPP {
        ppCurrent           =   dzenColor "#ad0536" "#1b1918" . pad
      , ppVisible           =   dzenColor "#444444" "#1b1918" . pad
      , ppHidden            =   dzenColor "#666666" "#1b1918" . pad
      , ppHiddenNoWindows   =   dzenColor "#444444" "#1b1918" . pad
      , ppUrgent            =   dzenColor "#ff0000" "#1b1918" . pad
      , ppWsSep             =   " "
      , ppSep               =   "  ///  "

      , ppTitle             =   (" " ++) . dzenColor "#444444" "#1b1918" . dzenEscape
      , ppOutput            =   hPutStrLn h
}

main = do
  status <- spawnPipe "dzen2 -h '24' -w '980' -ta 'l' -fg '#ad0536' -bg '#1b1918'"
  conky <- spawnPipe "conky -c ~/.xmonad/conky | dzen2 -x 980 -w 300 -h 24 -ta r -fg '#ad0536' -bg '#1b1918'"

  xmonad $ withUrgencyHook NoUrgencyHook $ baseConfig
    {
      terminal = "urxvt",
      modMask = mod4Mask,
      borderWidth = 3,
      normalBorderColor = "#111111",
      focusedBorderColor = "#ad0536",
      startupHook = startup,
      workspaces = [ "1", "2", "3", "4", "5", "6", "7", "8", "9" ],
      layoutHook = layout,
      logHook = loghook status
    }
