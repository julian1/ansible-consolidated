# deployed by ansible whoot!

# https://raspberrypi.stackexchange.com/questions/752/how-do-i-prevent-the-screen-from-going-blank
xset s off          # don't activate screensaver
xset -dpms          # disable DPMS (Energy Star) features.
xset s noblank      # don't blank the video device

xset r rate   200   # keyboard repeat rate fixes firefox scrolling
                    # 150 is too short. causes repeat in xterm terminal.

xset b off          # turn bell off


setxkbmap -option compose:ralt   # accented compose key is right alt

# setxkbmap -option caps:swapescape   # make caps-lock the escape key, and escape caps-lock. for vim etc.
# setxkbmap -option caps:escape         # to make caps-lock an additional escape

xrdb -merge <<- EOF
  XTerm*selectToClipboard: true
  XTerm*faceName: DejaVu Sans Mono
  XTerm*faceSize: 11
  XTerm*Background: black
  XTerm*Foreground: white
EOF

# keymap
xmodmap - <<- EOF
  ! numpad insert

  keycode 90 = Insert NoSymbol Insert

  # TODO - no longer used
  ! next and prev
  !  = Prior NoSymbol Prior
  !  = Next NoSymbol Next

  ! page up
  keycode 91 =  Up NoSymbol Up

  ! page down
  keycode 104 = Down NoSymbol Down

  ! numpad 2
  keycode 88 =  Home NoSymbol Home

  ! numpad 3
  keycode 89  = End  NoSymbol End
EOF

# brightness
# xrandr --output eDP1 --brightness .45
xrandr --output eDP-1 --brightness .55

# start pulse audio
pulseaudio --kill
sleep 0.5
pulseaudio --start


# start xmonad
xmonad

