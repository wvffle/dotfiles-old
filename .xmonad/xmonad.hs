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

baseConfig = desktopConfig

startup = do
  spawnOnce "feh --bg-fill ~/Desktop/wallpaper.jpg"
  spawnOnce "xrdb ~/.Xresources"
  spawnOnce "xmodmap ~/.Xmodmap"
  spawnOnce "compton -b --config ~/.config/compton/compton.conf &"
  setDefaultCursor xC_left_ptr

layout = spacing 10 $ gaps [(U, 34)] $ Tall 1 (3/100) (1/2)
loghook h = dynamicLogWithPP $ defaultPP 

main = do
  status <- spawnPipe "dzen2 -x '10' -y '10' -h '24' -w '1260' -ta 'l' -fg '#ad0536' -bg '#1b1918'"

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
