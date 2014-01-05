#
# ~/.bashrc
#

export MOZ_DISABLE_PANGO=1
export LESS="-R"
export EDITOR="vim"
export VISUAL="vim"

## default
#MYTERM=xterm-256color
#
## for screent
##if [ $TERM = "screen" ]; then
##    MYTERM=xterm
##fi
##
## for tmux: export 256color
#if [ -n "$TMUX" ]; then
#    #MYTERM=rxvt
#    MYTERM=screen-256color
#    #MYTERM=xterm-256color
#fi
#
#export TERM=$MYTERM

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Vi support
set -o vi

# Bash large history with no dupes
HISTCONTROL=erasedups:ignorespace
HISTSIZE=8000

# Basic stuff
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -alh'
alias sl='ls'
alias cls='clear'
alias grep='grep --color=auto'
alias myip='wget -q -O - checkip.dyndns.org'
#alias mplayer='mplayer -fs -x 1024 -y 600 -zoom mplayer -framedrop -cache 8192 -vo gl ' # using conf
alias tmux='tmux attach || tmux new'
alias sudo='A=`alias` sudo '
alias htop='TERM=screen htop -d 0,2'
alias v='vim'
alias vi='vim'
alias view='vim -R'
alias g='git'
alias :q='exit'
alias :Q='exit'
alias showclock='watch -n 1 "date +%T | xargs figlet \"Time:\" -c -t"'
alias histgrep='cat ~/.bash_history | grep'
alias todo='vim ~/Desktop/TODO.txt'
alias vimbashrc='vim ~/.bashrc && source ~/.bashrc'
alias openports='netstat --all --numeric --programs --inet --inet6'
#alias webshare='python2 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"' 
alias webshare='python -m http.server 12721'
alias makepassword='< /dev/urandom tr -dc A-Za-z0-9_ | head -c10 | xargs | cat'
alias ack='/usr/bin/vendor_perl/ack --color-match="bold red" --color-filename="green"'
alias makepkg32='linux32 makepkg -src --config ./makepkg.i686.conf'
alias logcat='adb logcat -c && logcat'
alias gdb='gdb -x ~/.gdbinit-color'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'    
alias ln='ln -i'

# privileged access
if [ $UID -ne 0 ]; then
   alias poweroff='sudo poweroff'
   alias mount='sudo mount'
   alias umount='sudo umount'
   alias sudo='sudo '
   alias scat='sudo cat'
   alias svim='sudo vim'
   alias root='sudo su'
   alias reboot='sudo reboot'
   alias halt='sudo halt'
   alias update='sudo pacman -Suy'
   alias pacman='sudo pacman '
   alias netcfg='sudo netcfg2'
fi

#PS1='[\u@\h \W]\$ '
PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
 
complete -cf sudo
complete -cf man
complete -cf mount

# Auto search for packs
source /usr/share/doc/pkgfile/command-not-found.bash

#man() {
#    env LESS_TERMCAP_mb=$'\E[01;31m' \
#    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
#    LESS_TERMCAP_me=$'\E[0m' \
#    LESS_TERMCAP_se=$'\E[0m' \
#    LESS_TERMCAP_so=$'\E[38;5;246m' \
#    LESS_TERMCAP_ue=$'\E[0m' \
#    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
#    man "$@"
#}

# man() {
# env LESS_TERMCAP_mb=$(tput bold; tput setaf 2) \
# LESS_TERMCAP_md=$(tput bold; tput setaf 6) \
# LESS_TERMCAP_me=$(tput sgr0) \
# LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) \
# LESS_TERMCAP_se=$(tput rmso; tput sgr0) \
# LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) \
# LESS_TERMCAP_ue=$(tput rmul; tput sgr0) \
# LESS_TERMCAP_mr=$(tput rev) \
# LESS_TERMCAP_mh=$(tput dim) \
# LESS_TERMCAP_ZN=$(tput ssubm) \
# LESS_TERMCAP_ZV=$(tput rsubm) \
# LESS_TERMCAP_ZO=$(tput ssupm) \
# LESS_TERMCAP_ZW=$(tput rsupm) \
# man "$@"
# }

# Man coloring
man() {
   env LESS_TERMCAP_mb=$'\E[01;31m' \
      LESS_TERMCAP_md=$'\E[01;38;5;75m' \
      LESS_TERMCAP_me=$'\E[0m' \
      LESS_TERMCAP_se=$'\E[0m' \
      LESS_TERMCAP_so=$'\E[01;33m' \
      LESS_TERMCAP_ue=$'\E[0m' \
      LESS_TERMCAP_us=$'\E[04;38;5;200m' \
      man "$@"
}
