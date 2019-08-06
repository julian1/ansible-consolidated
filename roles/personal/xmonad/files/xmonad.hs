-- deployed by ansible!

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

import XMonad.Util.SpawnOnce

-- intelij
import XMonad.Hooks.SetWMName


import qualified XMonad.StackSet as W



-- https://stackoverflow.com/questions/27742421/how-can-i-have-more-than-9-workspaces-in-xmonad

myExtraWorkspaces = [(xK_0, "0"),(xK_minus, "-"),(xK_equal, "+")]

myWorkspaces = ["1","2","3","4","5","6","7","8","9"] ++ (map snd myExtraWorkspaces)


mykeys = [
          ((mod1Mask ,  xK_z), spawn "xtrlock -b"),
          ((mod1Mask ,  xK_x), spawn "xtrlock -b")
        ] ++ [
         ((mod1Mask, key), (windows $ W.greedyView ws))
         | (key,ws) <- myExtraWorkspaces
       ] ++ [
        ((mod1Mask .|. shiftMask, key), (windows $ W.shift ws))
        | (key,ws) <- myExtraWorkspaces
       ]


-- myterminal = "xterm -fa 'DejaVu Sans Mono' -fs 10 -fg white -bg black"

-- 2018 GOOD
-- font and font size will inherit from .xinitrc,
-- but should be XTerm*faceName: DejaVu Sans Mono, XTerm*faceSize: 11   ! laptop
myterminal = "xterm  -fg white -bg black"


myLogHook dest = dynamicLogWithPP defaultPP { ppOutput = hPutStrLn dest
,ppVisible = wrap "(" ")"
}

main = do
-- xmproc <- spawnPipe "/usr/bin/xmobar /home/meteo/.xmobarrc"
-- xmonad should read ~/.xmobarrc by default, to avoid specify ~/
xmproc <- spawnPipe "xmobar"
xmonad $ defaultConfig
        {

      manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ layoutHook defaultConfig

    , workspaces = myWorkspaces

    , focusedBorderColor =  "#009900"
    , normalBorderColor  =  "#666666"

		, logHook = myLogHook xmproc

		, terminal = myterminal

		-- , startupHook = spawnOnce "/usr/bin/xmobar /home/meteo/.xmobarrc"

        -- intelij
        , startupHook = setWMName "LG3D"

        }
		`additionalKeys`
        mykeys


