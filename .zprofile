
# Setting path array
typeset -U path

# General
path=(~/bin ~/.gem/ruby/2.3.0/bin $path[@])

# Go env setup
export GOPATH=~/.godir
path=( ~/.godir/bin $path[@])

# Node js global
path=( ~/.node_modules/bin $path[@])

# Start X on login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec ssh-agent startx
