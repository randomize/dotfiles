#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X if on first VT (bash only)
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec ssh-agent startx
