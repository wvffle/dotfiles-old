import XMonad

import XMonad.ManageHook

import XMonad.Util.Run
import XMonad.Util.Cursor
import XMonad.Util.SpawnOnce

import XMonad.Config.Desktop
import XMonad.Util.EZConfig

import XMonad.Actions.FloatKeys

import XMonad.Layout.PerWorkspace
import XMonad.Layout.Fullscreen
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook

import System.IO
import System.Directory

baseConfig = desktopConfig

color1 = "#F7441C"
color2 = "#111111"
color3 = "#444444"
color4 = "#666666"

startup = do
  spawnOnce "feh --bg-fill ~/Desktop/wallpaper.jpg"
  spawnOnce "xrdb ~/.Xresources"
  spawnOnce "xmodmap ~/.Xmodmap"
  spawnOnce "compton -b --config ~/.config/compton/compton.conf&"
  setDefaultCursor xC_left_ptr

main = do
  home <- getHomeDirectory

  let workspaceNames = [
          "^i(" ++ home ++ "/.dzen2/fox.xbm)"
        , "^i(" ++ home ++ "/.dzen2/code.xbm)"
        , "^i(" ++ home ++ "/.dzen2/term.xbm)"
        , "^i(" ++ home ++ "/.dzen2/phones.xbm)"
        , "^i(" ++ home ++ "/.dzen2/art.xbm)"
        , "^i(" ++ home ++ "/.dzen2/media.xbm)"
        , "^i(" ++ home ++ "/.dzen2/docs.xbm)"
        , "^i(" ++ home ++ "/.dzen2/games.xbm)"
        , "^i(" ++ home ++ "/.dzen2/mail.xbm)"
        ]

  let layout = onWorkspace (workspaceNames !! 0) (
          ( spacing 10 $ gaps [(U, 24)] $ Full )
        ) $
        onWorkspace (workspaceNames !! 1) (
          ( gaps [(U, 24)] $ withBorder 1 $ Tall 1 (3/100) (1/2) )
        ) $
        onWorkspace (workspaceNames !! 2) (
          ( gaps [(U, 24)] $ withBorder 1 $ Tall 1 (3/100) (1/2) )
        ) $
        avoidStruts (
          ( spacing 10 $ Tall 1 (3/100) (1/2) )   |||
          ( withBorder 1 $ Tall 1 (3/100) (1/2) ) |||
          ( spacing 10 $ Full )
        )

  let loghook h = dynamicLogWithPP $ defaultPP {
          ppCurrent           =   dzenColor color1 color2 . pad
        , ppVisible           =   dzenColor color3 color2 . pad
        , ppHidden            =   dzenColor color4 color2 . pad
        , ppHiddenNoWindows   =   dzenColor color3 color2 . pad
        , ppUrgent            =   dzenColor "#ff0000" color2 . pad
        , ppWsSep             =   " "
        , ppSep               =   "  ///  "
        , ppLayout            =   dzenColor color3 color2 .
          (\x -> case x of
            "Spacing 10 Full"             ->  "^i(" ++ home ++ "/.dzen2/layout_full.xbm)"
            "Tall"             ->  "^i(" ++ home ++ "/.dzen2/layout_tall.xbm)"
            "Spacing 10 Tall"  ->  "^i(" ++ home ++ "/.dzen2/tall.xbm)"
            _                  ->  "^i(" ++ home ++ "/.dzen2/grid.xbm)"
          )
        , ppTitle             =   (" " ++) . dzenColor color3 color2 . dzenEscape
        , ppOutput            =   hPutStrLn h
  }

  let manageh = composeAll [
          className =? "Firefox" --> doShift (workspaceNames !! 0)
        , resource  =? "spotify" --> doShift (workspaceNames !! 3)
        , resource  =? "discord" --> doShift (workspaceNames !! 8)
        ]
  let manage = manageh <+> manageHook defaultConfig

  status <- spawnPipe ( "dzen2 -h '24' -w '980' -ta 'l' -fg '" ++ color1 ++ "' -bg '" ++ color2 ++ "'" )
  conky <- spawnPipe ( "conky -c ~/.xmonad/conky | dzen2 -x 980 -w 300 -h 24 -ta r -fg '" ++ color1 ++ "' -bg '" ++ color2 ++ "'" )

  xmonad $ withUrgencyHook NoUrgencyHook $ baseConfig
    {
      terminal = "urxvt",
      modMask = mod4Mask,
      borderWidth = 3,
      normalBorderColor = color2,
      focusedBorderColor = color1,
      startupHook = startup,
      workspaces = workspaceNames,
      layoutHook = layout,
      logHook = loghook status,
      manageHook = manage
    }

    `additionalKeys`
    [
      ((mod4Mask .|. mod1Mask,               xK_h), withFocused (keysMoveWindow (-20, 0)))
    , ((mod4Mask .|. mod1Mask,               xK_j), withFocused (keysMoveWindow (0,  20)))
    , ((mod4Mask .|. mod1Mask,               xK_k), withFocused (keysMoveWindow (0, -20)))
    , ((mod4Mask .|. mod1Mask,               xK_l), withFocused (keysMoveWindow (20,  0)))
    , ((mod4Mask .|. mod1Mask .|. shiftMask, xK_h), withFocused (keysResizeWindow (-20, 0) (0, 0)))
    , ((mod4Mask .|. mod1Mask .|. shiftMask, xK_j), withFocused (keysResizeWindow (0,  20) (0, 0)))
    , ((mod4Mask .|. mod1Mask .|. shiftMask, xK_k), withFocused (keysResizeWindow (0, -20) (0, 0)))
    , ((mod4Mask .|. mod1Mask .|. shiftMask, xK_l), withFocused (keysResizeWindow (20,  0) (0, 0)))
    ]
