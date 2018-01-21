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

myterminal :: String

-- inherit font size from Xdefaults

myterminal = "xterm "
-- myterminal = "xterm -fa 'DejaVu Sans Mono'  -fg black -bg white "
-- myterminal = "xterm -fa 'DejaVu Sans Mono' -fs 10 -fg black -bg white "

myLogHook dest = dynamicLogWithPP defaultPP { ppOutput = hPutStrLn dest
,ppVisible = wrap "(" ")"
} 

main = do
xmproc <- spawnPipe "/usr/bin/xmobar /home/meteo/.xmobarrc"
xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig

    , focusedBorderColor =  "#009900"
    , normalBorderColor  =  "#666666" 

		, logHook = myLogHook xmproc 

		, terminal = myterminal 

		-- , startupHook = spawnOnce "/usr/bin/xmobar /home/meteo/.xmobarrc"

        -- intelij
        , startupHook = setWMName "LG3D"

        } 
		`additionalKeys`
        [ 
          ((mod1Mask ,  xK_z), spawn "xtrlock -b"),
          ((mod1Mask ,  xK_x), spawn "xtrlock -b")
        ]


