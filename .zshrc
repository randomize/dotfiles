# =========================================================================== #
#   Zsh config
#   Configured by Randomize, 2012-2014
#
#   Thanks to:
#   msjche,
#
# =========================================================================== #
#


# Support for evaluating a function on startup
if [[ $1 == eval ]]
then
   "$@"
   set --
fi

[[ -s /etc/profile.d/autojump.zsh ]] && . /etc/profile.d/autojump.zsh

# Setup colors in tty conoles ===============================================================
#
function set-randy-colors() {
   echo -en "\e]P0131313" #black
   echo -en "\e]P82B2B2B" #darkgrey
   echo -en "\e]P1D75F5F" #darkred
   echo -en "\e]P9E33636" #red
   echo -en "\e]P287AF5F" #darkgreen
   echo -en "\e]PA98E34D" #green
   echo -en "\e]P3D7AF87" #brown
   echo -en "\e]PBFFD75F" #yellow
   echo -en "\e]P48787AF" #darkblue
   echo -en "\e]PC7373C9" #blue
   echo -en "\e]P5BD53A5" #darkmagenta
   echo -en "\e]PDD633B2" #magenta
   echo -en "\e]P65FAFAF" #darkcyan
   echo -en "\e]PE44C9C9" #cyan
   echo -en "\e]P7E5E5E5" #lightgrey
   echo -en "\e]PFEEEEEE" #white
   clear #for background artifacting
}

if [ "$TERM" = "linux" ];
then
   set-randy-colors
fi

# Variables ==================================================================================
#

export PATH="${PATH}:${HOME}/bin"
eval `dircolors -b $HOME/.dircolors`

# Zsh Options ==================================================================================

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY # Timestamp history


# Completion

autoload -Uz compinit && compinit
# http://www.acm.uiuc.edu/workshops/zsh/prompt/escapes.html

# From gentoo wiki
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' 
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'


# Following causes empty directory slowdown - commented
#zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _match _correct _approximate
zstyle ':completion:*' file-sort access
zstyle ':completion:*' matcher-list '' ''
zstyle ':completion:*' max-errors 100 numeric
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''

# Color on suggestions to display partial match
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==32=00}:${(s.:.)LS_COLORS}")';

# Processes
# zstyle ':completion:*:processes' command 'ps -aux'
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
zstyle ':completion:*:processes' command 'NOCOLORS=1 ps -U $(whoami)|sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select
zstyle ':completion:*:processes-names' command 'NOCOLORS=1 ps xho command|sed "s/://g"'
zstyle ':completion:*:processes' sort false



###
# Prompts ==================================================================================
autoload -U colors && colors

export BASE_PS1="%{$fg_bold[green]%}%n@%M %{$fg_bold[blue]%}%1~%{$reset_color%}"
# export RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
RPROMPT="%B%{$fg[black]%}%~%{$reset_color%}"

# Making vim modes visible with hooks
function zle-line-init zle-keymap-select {
   VIM_ON="%{$fg_bold[red]%}$%{$reset_color%}"
   VIM_OFF="%{$fg_bold[green]%}$%{$reset_color%}"
   PS1="$BASE_PS1 ${${KEYMAP/vicmd/$VIM_ON}/(main|viins)/$VIM_OFF} "
   #RPS1="${${KEYMAP/vicmd/N}/(main|viins)/I}"
   #RPS2=$RPS1
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

setopt autopushd pushdminus pushdsilent pushdtohome

# To avoid tedious 'cd ' typing, just type directory name to cd to it
setopt autocd

setopt cdablevars
setopt ignoreeof
setopt interactivecomments
setopt nobanghist
setopt noclobber
#setopt SH_WORD_SPLIT
setopt CORRECT
# setopt MENUCOMPLETE
setopt nohup
setopt ALL_EXPORT

# Keyboard ==================================================================================

# Run in vim mode
bindkey -v
export KEYTIMEOUT=1

# Home key, fixes in urxvt, not xterm
bindkey -v '^[[1~' beginning-of-line
bindkey -a '^[[1~' beginning-of-line

# End key
bindkey -v '^[[4~' end-of-line
bindkey -a '^[[4~' end-of-line

# Delete key
bindkey -v '^[[3~' delete-char
bindkey -a '^[[3~' delete-char

# Page Up and Page Down
bindkey -v '^[[5~' up-history
bindkey -a '^[[5~' up-history
bindkey -v '^[[6~' down-history
bindkey -a '^[[6~' down-history

# Backspace key fix
bindkey -v '^H' backward-delete-char
bindkey -a '^H' backward-delete-char
bindkey -v '^?' backward-delete-char
bindkey -a '^?' backward-char

# Undo / Redo
bindkey -a u undo
bindkey -a '^R' redo

# Unknown stuff
#bindkey '^[[9~' beginning-of-line
#bindkey '^[[8~' end-of-line
#bindkey '^[OD' backward-word
#bindkey '^[OC' forward-word
#bindkey '^[^[[D' stack-cd-forward
#bindkey '^[^[[C' stack-cd-backward
#bindkey '^[[1;3D' stack-cd-forward
#bindkey '^[[1;3C' stack-cd-backward
#bindkey '^[[Z' reverse-menu-complete
# bindkey '^h' backward-delete-char

# History search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Stupid arrows
bindkey -v '^[[A' up-line-or-beginning-search
bindkey -v '^[[B' down-line-or-beginning-search
# Alt+jk
bindkey -v '\ek'  up-line-or-beginning-search
bindkey -v '\ej'  down-line-or-beginning-search
# normal mode jk
bindkey -a 'k'    up-line-or-beginning-search
bindkey -a 'j'    down-line-or-beginning-search

# Search backwards and forwards with a pattern
# normal mode
bindkey -a '/' history-incremental-pattern-search-backward
bindkey -a '?' history-incremental-pattern-search-forward
# Ctrl+rf
# bindkey -v '^r' history-incremental-pattern-search-backward
# bindkey -v '^f' history-incremental-pattern-search-forward
# Alr+rf
bindkey -v '\er' history-incremental-pattern-search-backward
bindkey -v '\ef' history-incremental-pattern-search-forward

# Clear screen <a-c>
bindkey -v '\ec' clear-screen


# Enable exit on Ctrl+D
extended_logout() {
   exit
}
zle -N extended-logout extended_logout
bindkey -a '^d' extended-logout
bindkey -v '^d' extended-logout

# Mapping Alt+S to custom function that inserts sudo
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey '\es' insert-sudo

# Mapping <a-o> to add less
bindkey -s '\eo' ' | less'

# Insert last word with Alt+. -- cool!
bindkey '\e.' insert-last-word

bindkey '\eh' backward-char
bindkey '\el' forward-char

bindkey '\ey' accept-and-hold

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ex' edit-command-line
bindkey -M vicmd v edit-command-line

# Make Shift-TAB work as backward complete
bindkey '^[[Z' reverse-menu-complete

# Make delete by word parts with Alt+w
tcsh-backward-kill-word() {
  local WORDCHARS="${WORDCHARS:s@/@}"
  zle backward-kill-word
}
zle -N tcsh-backward-kill-word
bindkey '\ew' tcsh-backward-kill-word

# Make Ctrl+W to erase word
bindkey '^w' backward-kill-word

# Toggle Ctrl+Z vim
foreground-vi() {
  fg %vim
}
zle -N foreground-vi
bindkey -a '^Z' foreground-vi
bindkey -v '^Z' foreground-vi

# Pasting from clipboard
vi-append-x-selection () { RBUFFER=$(xsel -o -p </dev/null)$RBUFFER; }
vi-append-x-clipboard () { RBUFFER=$(xsel -o -b </dev/null)$RBUFFER; }
zle -N vi-append-x-selection
zle -N vi-append-x-clipboard

bindkey -v '^[[2~' vi-append-x-clipboard
bindkey -a '^[[2~' vi-append-x-clipboard

# File associations aliases ==================================================================================

# Browser things
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER

# Text things
alias -s txt=$EDITOR
alias -s h=$EDITOR
alias -s cpp=$EDITOR
alias -s java=$EDITOR
alias -s conf=$EDITOR
alias -s PKGBUILD=$EDITOR

# Images
alias -s png=feh
alias -s jpg=feh
alias -s jpeg=feh
alias -s gif=feh
alias -s tiff=feh

# Office
alias -s sxw=soffice
alias -s doc=soffice

# Media
alias -s avi=mpv
alias -s mov=mpv
alias -s mkv=mpv
alias -s mp4=mpv

# Archives
alias -s gz=unp -u
alias -s tgz=unp -u
alias -s bz2=unp -u
alias -s tar=unp -u
alias -s 7z=unp -u
alias -s zip=unp -u
alias -s rar=unp -u

# Other
alias -s pdf=zathura
alias -s djvu=zathura
alias -s torrent=~/bin/download_torrent.sh

# Aliases ==================================================================================

# Listing
alias ls='ls --color=auto -F -h'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias la='ls++ -a'
alias ll='ls++'
alias l='ll'
alias sl='ls'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# Shell
alias :q='exit'
alias :Q='exit'
alias cls='clear'
alias h='history'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'
alias acp='acp -ig'
alias amv='amv -ig'

alias g='git'
alias gap='git add --patch'

alias pa='pacman'
alias ya='yaourt'

alias clock='watch -n 1 "date +%T | xargs figlet \"Time:\" -c -t"'
alias todo='vim ~/Desktop/TODO.txt'
alias openports='netstat --all --numeric --programs --inet --inet6'
alias webshare='python -m http.server 12721'
alias webshare2='twistd -no web --path=. --port=12721'
alias makepassword='< /dev/urandom tr -dc A-Za-z0-9_ | head -c10 | xargs | cat'
alias makenumber='< /dev/urandom tr -dc 0-9 | head -c16 | xargs | cat'
alias ag='ag --color-match 38\;5\;197 --color-line-number 38\;5\;110 --color-path 38\;5\;215\;4'
alias ack=ag
alias mstream='mplayer -playlist'
alias grep='grep --colour'
alias fgrep='grep --colour'
alias egrep='egrep --colour'
alias free='free -m'
alias htop='htop -d 2'
alias fehdir='feh -g 640x480 -d -S filename'

# Programming
alias cmake-release='cmake -DCMAKE_BUILD_TYPE=Release'
alias cmake-debug='cmake -DCMAKE_BUILD_TYPE=Debug'

# Sudoing
alias sudo='sudo '
alias poweroff='sudo poweroff'
alias mount='sudo mount'
alias umount='sudo umount'
alias scat='sudo cat'
alias svim='sudoedit'
alias reboot='sudo reboot'
alias halt='sudo halt'
alias update='sudo pacman -Suy'

# IPad management
alias mount-ipad-pdf='ifuse --appid com.readdle.PDFExpertIPad /mnt/ipad && cd /mnt/ipad'
alias mount-ipad-video='ifuse --appid AVPlayerHD.eplayworks.com /mnt/ipad && cd /mnt/ipad'
alias mount-ipad-djvu='ifuse --appid com.qzyzx.SoleDjVu /mnt/ipad && cd /mnt/ipad'
alias mount-ipad-root='ifuse --root /mnt/ipad && cd /mnt/ipad'
alias umount-ipad='cd ~ && umount /mnt/ipad'
alias mount-mac='sudo sshfs  randy@10.10.10.105:/ /mnt/macos'

# Tools
#alias bindiff='cmp -l file1.bin file2.bin | gawk \'{printf \"%08X %02X %02X\n\", $1, strtonum(0$2), strtonum(0$3)}\''
alias vim-clean-views='rm ~/.vim/view/*'
alias list-devices='lsblk -f'
alias sdcv='sdcv --color'
alias sdc='sdcv -u "LingvoUniversal (En-Ru)" --color'
alias cgdb='cgdb -- -nx '

## Editing aliases
alias eA='vim ~/.config/awesome/rc.lua'
alias eX='vim ~/.Xresources && xrdb -merge ~/.Xresources'
alias eZ='vim ~/.zshrc && source ~/.zshrc'
alias eV='vim ~/.vimrc'
alias eC='vim ~/nfo/commands.txt'
alias eS='vim ~/nfo/setup.txt'
alias eP='vim ~/nfo/paks.txt'
alias eT='vim ~/.tmux.conf'
alias eI='vim ~/.xinitrc'

## Frequent places
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cdA='cd ~/.config/awesome'
alias cdT='cd /mnt/TERRA'
alias cdB='cd /mnt/TERRA/Books'
alias cdD='cd ~/Downloads && ll'

## Vim aliases
alias e='vim'
alias v='vim'
alias vi='vim'
alias view='vim -R'

alias sniff-flv='sudo ngrep -d any '.flv'  port 80'

## Virtual Box
alias vb-macos='VBoxManage startvm "VM Mac OS Mavericks"'
alias vb-windows='VBoxManage startvm "Window 8"'
alias vb-xp='VBoxManage startvm "WinXP"'

# Functions ==================================================================================

# Set brightness
function brightness() {
   sudo ddccontrol -r 0x10 dev:/dev/i2c-6 -w "$1"
}

# sibdiff Source Destination ../../some/tricky/../path/to/file.cpp
function sibdiff() {
   # Simple zsh magick - replacing in full path $3:A $1 with $2
   vimdiff ${${3:A}/${1}/${2}} ${3:A}
}

## Cd and list
function cdd(){ cd "$1" ; ls --color}

mkcd() { mkdir -p "$*" && cd "$*"; }
lss()  { tree $@ | less }
wiki() { dig +short txt $(echo "$*" | tr ' ' _).wp.dg.cx }
lls()  { locate "$*" | less }
vkplay() { xclip -o | cut -d \" -f 2 | xargs getvk.py --best | xargs mpv }
vklist() { xclip -o | cut -d \" -f 2 | xargs getvk.py  }

## Pacman stuff
pacdesc() { pacman -Qi $1 | grep "Description" }
who-owns() { pacman -Qo `which $1` }

## Command-line calculator
calc() { python -ic "from __future__ import division; from math import *; from random import *" ;}

## Commandline Fu
cmdfu() { curl "http://www.commandlinefu.com/commands/matching/$(echo "$@" \
        | sed 's/ /-/g')/$(echo -n $@ | base64)/plaintext" ;}

##Check if websites are down
down4me() { curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g';}

## Google Translate Functions ##

say() {
   mplayer -user-agent Mozilla -prefer-ipv4 \
   "http://translate.google.md/translate_tts?ie=UTF-8&tl="$1"&q=$(echo "$@" \
   | cut -d ' ' -f2- | sed 's/ /\+/g')" > /dev/null 2>&1 ;
}

say-translation() {
   lang=$1
   trans=$(translate {=$lang} "$(echo "$@" | cut -d ' ' -f2- | sed 's/ /\+/g')" )
   echo $trans
   mplayer -user-agent Mozilla \
   "http://translate.google.com/translate_tts?ie=UTF-8&tl=$lang&q=$trans" > /dev/null 2>&1 ;
}

# Misc stuff ==================================================================================
#
unsetopt ALL_EXPORT

# Auto notify on command not found
source /usr/share/doc/pkgfile/command-not-found.zsh


# Colorize mans
man() {

  # LESS_TERMCAP_mb=$(printf "\e[1;34m") \
  # LESS_TERMCAP_md=$(printf "\e[1;34m") \
  # LESS_TERMCAP_me=$(printf "\e[0m") \
  # LESS_TERMCAP_se=$(printf "\e[0m") \
  # LESS_TERMCAP_so=$(printf "\e[1;31m") \
  # LESS_TERMCAP_ue=$(printf "\e[0m") \
  # LESS_TERMCAP_us=$(printf "\e[1;32m") \

  env \
  LESS_TERMCAP_mb=$'\E[01;31m'       \
  LESS_TERMCAP_md=$'\E[01;38;5;74m'  \
  LESS_TERMCAP_me=$'\E[0m'           \
  LESS_TERMCAP_se=$'\E[0m'           \
  LESS_TERMCAP_so=$'\E[38;5;220;1m'  \
  LESS_TERMCAP_ue=$'\E[0m'           \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}

# Colorize less
less() {
  env \
  LESS_TERMCAP_mb=$(printf "\e[1;34m") \
  LESS_TERMCAP_md=$(printf "\e[1;34m") \
  LESS_TERMCAP_me=$(printf "\e[0m") \
  LESS_TERMCAP_se=$(printf "\e[0m") \
  LESS_TERMCAP_so=$(printf "\e[1;31m") \
  LESS_TERMCAP_ue=$(printf "\e[0m") \
  LESS_TERMCAP_us=$(printf "\e[1;32m") \
  less "$@"
}

zman() {
  PAGER="less -g -s '+/^       "$1"'" man zshall
}



# Plugins and external stuff ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


# 1. Dir stack =========================================================================

DIRSTACKSIZE=16
#DIRSTACKFILE=~/.zdirs
#if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
#  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
#  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
#fi
#chpwd() {
#  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
#}

DIRSTACKFILE=~/.cache/.zdirs

autoload -U is-at-least
# Keep dirstack across logouts
if [[ -f ${DIRSTACKFILE} ]] && [[ ${#dirstack[*]} -eq 0 ]] ; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    dirstack=( ${(u)dirstack} )
fi

# Make sure there are no duplicates
typeset -U dirstack

# Share dirstack between multiple zsh instances
function chpwd() {
    if is-at-least 4.1; then # dirs -p needs 4.1
        # Get the dirstack from the file and add it to the current dirstack
        dirstack+=( ${(f)"$(< $DIRSTACKFILE)"} )
        dirstack=( ${(u)dirstack} )
        dirs -pl |sort -u >! ${DIRSTACKFILE}
    fi
}

alias dh='dirs -v'
setopt AUTOPUSHD         # push on cd
setopt PUSHDMINUS        # swap +1 to -1 syntax
setopt PUSHDSILENT       # no noise
setopt PUSHDTOHOME       # not sure
setopt PUSHD_IGNOREDUPS  # unique only


# 2. Highlighting ======================================================================

# Highlighting package must be installed by pacman
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets )
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=yellow
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=fg=white,bold

ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('rm -fr *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('kill *' 'fg=red,bold,underline')
ZSH_HIGHLIGHT_PATTERNS+=('pkill *' 'fg=red,bold,underline')
ZSH_HIGHLIGHT_PATTERNS+=('killall *' 'fg=red,bold,underline')


# 3. Command finished notification =====================================================

# Bell - when command finished
if [ -f ~/.zsh/zbell.sh ]; then
   . ~/.zsh/zbell.sh
fi

# 3.1 Listing with k =====================================================
# K - new ls ;)
if [ -f ~/.zsh/k.sh ]; then
   . ~/.zsh/k.sh
fi

# 4. FFMpeg ============================================================================

ffx_MONO="1"            # mono
ffx_DUAL="2"            # dual channel
ffx_HW="hw:1,0"         # alsa; run 'cat /proc/asound/pcm' to change to the correct numbers
ffx_PULSE="pulse"       # pulseaudio; might have to install pavucontrol to change volume
ffx_FPS="30"            # frame per seconds
ffx_WIN_FULL="1920x1080"        # record fullscreen
ffx_AUDIO="pcm_s16le"   # audio codec
ffx_VIDEO="libx264"     # video codec
ffx_PRESET="ultrafast"  # preset error? run 'x264 -h' replace with fast,superfast, slow ..etc
ffx_CRF="0"
ffx_THREADS="0"
ffx_SCALE="scale=1920x1080"     # scale resolution, no black bars on sides of video on youtube
ffx_OUTPUT=~/screencast.avi
ffx_OUTPUT_FINAL=~/screencast.mp4
# Note: -vf is optional delete if you want, -y is to overwrite existing file

alias FF='ffmpeg -f alsa -i pulse -f x11grab -r 15 -s 1920x1080 -i :0.0 -acodec pcm_s16le -vcodec huffyuv -sameq ~/screencasts/screencast.avi'

FF-full()
{
        ffmpeg \
        -f alsa \
        -ac $ffx_MONO \
        -i $ffx_PULSE \
        -f x11grab \
        -r $ffx_FPS \
        -s 1920x1280 \
        -i :0.0+0,0 \
        -acodec $ffx_AUDIO \
        -vcodec $ffx_VIDEO \
        -preset $ffx_PRESET \
        -crf $ffx_CRF \
        -threads $ffx_THREADS \
        -y $ffx_OUTPUT \
}
#       -s ffx_WIN_FULL \
#       -vf $ffx_SCALE \


# capture single window, use mouse cursor to select window you want to record
FF-window()
{
        ffx_INFO=$(xwininfo -frame)
        ffmpeg \
        -f alsa \
        -ac $ffx_MONO \
        -i $ffx_PULSE \
        -f x11grab \
        -r $ffx_FPS \
        -s $(echo $ffx_INFO \
           | grep -oEe 'geometry [0-9]+x[0-9]+'\
           | grep -oEe '[0-9]+x[0-9]+') \
        -i :0.0+$(echo $ffx_INFO \
           | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' \
           | grep -oEe '[0-9]+\+[0-9]+' \
           | sed -e 's/\+/,/' ) \
        -acodec $ffx_AUDIO \
        -vcodec $ffx_VIDEO \
        -preset $ffx_PRESET \
        -crf $ffx_CRF \
        -threads $ffx_THREADS \
        -y $ffx_OUTPUT \
}

FF-convert()
{
    ffmpeg \
        -i $ffx_OUTPUT \
        -ar 22050 \
        -ab 32k \
        -strict -2 \
         $ffx_OUTPUT_FINAL
}

Convert()
{
    ffmpeg \
        -i $1 \
        -ar 22050 \
        -ab 32k \
        -strict -2 \
         output.avi
}

# set an ad-hoc GUI timer
timer() {
  local N=$1; shift

  (sleep $N && zenity --info --title="Time's Up" --text="${*:-BING}") &
  echo "timer set for $N"
}

highlightkeynote() { highlight --font=Consolas --font-size=24 --style=molokai -i "$@" -O rtf ;}

function psgrep() { ps axuf | grep -v grep | grep "$@" -i }
function fname() { find . -iname "*$@*"; }

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/home/randy/cocos2d-x/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable NDK_ROOT for cocos2d-x
export NDK_ROOT=/opt/android-ndk
export PATH=$NDK_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Add environment variable ANT_ROOT for cocos2d-x
export ANT_ROOT=/usr/bin
export PATH=$ANT_ROOT:$PATH
