
# Start X on login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec ssh-agent startx >> ~/.cache/startx.log
