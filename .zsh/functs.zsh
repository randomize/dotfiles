# Helper functions
function forallpgp() { git submodule foreach "[[ \"\$path\" != *\"module\" ]] || $* " }

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
function calc() { ipython -i -c "from math import *; from random import *; import numpy as np" --TerminalInteractiveShell.editing_mode=vi ;}

# Check if websites are down
function down4me() { curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g';}

# Screencasting
function recordscreen-main() 
{
    screenkey --scr 0 -s small
    ffmpeg \
       -f alsa \
       -ac 2 \
       -i pulse \
       -f x11grab \
       -framerate 30 \
       -video_size 2560x1440 \
       -i :0.0 \
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
    screenkey --scr 1 -s small
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


function go-dvorak()
{
    setxkbmap -layout "dvp, us, ru" -option "grp:shifts_toggle"
    setxkbmap -option ctrl:nocaps 
    setxkbmap -option terminate:ctrl_alt_bksp
    xset r rate 400 80
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


fd() {
  DIR=`find * -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

fda() {
  DIR=`find ${1:-.} -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

# Searches only for source C# files
fe() {
  local files
  IFS=$'\n' files=($(rg --files --type cs 2> /dev/null | fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && xdg-open "$file" || ${EDITOR:-vim} "$file"
  fi
}

vf() {
  local files
  IFS=$'\n' files=($(rg --files $*  2> /dev/null | fzf-tmux --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed 's/ *[0-9]* *//' | sort | uniq | fzf-tmux +s --tac)
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf-tmux -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}


# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

hogs() {
 ps aux | sort -nrk 3,3 | head -n 10
}

zf() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf-tmux -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# fasd & fzf - open with vim, mpv and xdg-open
v() {
    [ $# -gt 0 ] && fasd -f -e nvim "$*" && return
    local file
    file="$(fasd -Rfl "$1" | fzf-tmux -1 -0 --no-sort +m)" && nvim "${file}" || return 1
}

m() {
    [ $# -gt 0 ] && fasd -f -e mpv "$*" && return
    local file
    file="$(fasd -Rfl "$1" | fzf-tmux -1 -0 --no-sort +m)" && mpv "${file}" || return 1
}

fmpc() {
  local song_position
  song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
    fzf-tmux --query="$1" --reverse --select-1 --exit-0 | \
    sed -n 's/^\([0-9]\+\)).*/\1/p') || return 1
  [ -n "$song_position" ] && mpc -q play $song_position
}

# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

fp() {
 local out file key
 IFS=$'\n' out=($(pacman -Qq | fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
 key=$(head -1 <<< "$out")
 file=$(head -2 <<< "$out" | tail -1 )
 if [ -n "$file" ]; then
 [ "$key" = ctrl-o ] && pacman -Ql "$file" || pacman -Qi "$file"
 fi
}
