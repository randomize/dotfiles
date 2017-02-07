# Helper functions

# Simple timers
function stopwatch()
{
    date1=`date +%s`; 
    while true; do 
        setterm -cursor off
        tput clear
        echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r" | cowsay
        sleep 0.5
    done
    setterm -cursor on
}

function timer()
{
    local N=$1; shift
    (sleep "${N}" && notify-send -u critical "Time's Up" "${*:-BING}") &
    echo "timer set for ${N} seconds "
}

function clean-git()
{
    rm .gitignore
    git clean -df
    git reset HEAD --hard
}

# Cd and list
function cdd(){ cd "$1" ; ls --color}

# Make and cd
function mkcd() { mkdir -p "$*" && cd "$*"; }

# Tree
function lss()  { tree $@ | less }

function wiki() { dig +short txt $(echo "$*" | tr ' ' _).wp.dg.cx }
function lls()  { locate "$*" | less }
function fn () { find . -iname "*$1*" -print }
function lsunity() { tar -axf "$1" --wildcards --no-anchored '*pathname*' --to-command="echo '' && cat" | sort }

# Command-line calculator
function calc() { python -ic "from __future__ import division; from math import *; from random import *" ;}

# Check if websites are down
function down4me() { curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g';}

# Screencasting
function recordscreen-main() 
{
    ffmpeg \
       -f alsa \
       -ac 2 \
       -i pulse \
       -f x11grab \
       -framerate 30 \
       -video_size 2560x1440 \
       -i :0.0+1280 \
       -c:v libx264 \
       -preset ultrafast \
       -qp 0 \
       -threads 0 \
       -c:a pcm_s16le \
       -af aresample=async=1:first_pts=0 \
       "cast-$(date +"%F-%I-%M-%s").mkv"
}

function recordscreen-small() 
{
    screenkey --scr 0 -s small
    ffmpeg \
       -f alsa \
       -ac 2 \
       -i pulse \
       -f x11grab \
       -framerate 30 \
       -video_size 1280x1024 \
       -i :0.0+2560 \
       -c:v libx264 \
       -preset ultrafast \
       -qp 0 \
       -threads 0 \
       -c:a pcm_s16le \
       -af aresample=async=1:first_pts=0 \
       "cast-$(date +"%F-%I-%M-%s").mkv"
    killall screenkey
}



# Quck helper for scripting - selects column like: | aprint 2
function aprint() { awk "{print \$${1:-1}}"; }

# Usage: codi [filetype] [filename]
codi()
{
    local syntax="${1:-python}"
    shift
    vim -c \
        "let g:startify_disable_at_vimenter = 1 |\
        set bt=nofile ls=0 noru nonu nornu |\
        hi ColorColumn ctermbg=NONE |\
        hi VertSplit ctermbg=NONE |\
        hi NonText ctermfg=0 |\
        Codi $syntax" "$@"
}
