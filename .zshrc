# =========================================================================== #
#   Zsh config
#   Made by Randomize, 2012-2014
#   DWTFYW License
# =========================================================================== #

# Support for evaluating a function on startup
if [[ $1 == eval ]]
then
    "$@"
set --
fi

# Variables ==================================================================================
#
export EDITOR="vim"
#export PAGER="most -s"
export PATH="${PATH}:${HOME}/bin"

# Setup cocos2dx paths ans vars
export COCOS_CONSOLE_ROOT=/home/randy/cocos2d-x/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH
export NDK_ROOT=/home/randy/android/ndk
export PATH=$NDK_ROOT:$PATH
export ANDROID_SDK_ROOT=/home/randy/android/sdk
export PATH=$ANDROID_SDK_ROOT:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH
export ANT_ROOT=/usr/bin

eval `dircolors -b`

# Zsh Options ==================================================================================

# Coloring is fun
#fg_black=%{$'\e[0;30m'%}
#fg_red=%{$'\e[0;31m'%}
#fg_green=%{$'\e[0;32m'%}
#fg_brown=%{$'\e[0;33m'%}
#fg_blue=%{$'\e[0;34m'%}
#fg_purple=%{$'\e[0;35m'%}
#fg_cyan=%{$'\e[0;36m'%}
#fg_lgray=%{$'\e[0;37m'%}
#fg_dgray=%{$'\e[1;30m'%}
#fg_lred=%{$'\e[1;31m'%}
#fg_lgreen=%{$'\e[1;32m'%}
#fg_yellow=%{$'\e[1;33m'%}
#fg_lblue=%{$'\e[1;34m'%}
#fg_pink=%{$'\e[1;35m'%}
#fg_lcyan=%{$'\e[1;36m'%}
#fg_white=%{$'\e[1;37m'%}
##Text Background Colors
#bg_red=%{$'\e[0;41m'%}
#bg_green=%{$'\e[0;42m'%}
#bg_brown=%{$'\e[0;43m'%}
#bg_blue=%{$'\e[0;44m'%}
#bg_purple=%{$'\e[0;45m'%}
#bg_cyan=%{$'\e[0;46m'%}
#bg_gray=%{$'\e[0;47m'%}
##Attributes
#at_normal=%{$'\e[0m'%}
#at_bold=%{$'\e[1m'%}
#at_italics=%{$'\e[3m'%}
#at_underl=%{$'\e[4m'%}
#at_blink=%{$'\e[5m'%}
#at_outline=%{$'\e[6m'%}
#at_reverse=%{$'\e[7m'%}
#at_nondisp=%{$'\e[8m'%}
#at_strike=%{$'\e[9m'%}
#at_boldoff=%{$'\e[22m'%}
#at_italicsoff=%{$'\e[23m'%}
#at_underloff=%{$'\e[24m'%}
#at_blinkoff=%{$'\e[25m'%}
#at_reverseoff=%{$'\e[27m'%}
#at_strikeoff=%{$'\e[29m'%}

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY # Timestamp history


# Completion
zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _match _correct _approximate
zstyle ':completion:*' file-sort access
zstyle ':completion:*' matcher-list '' ''
zstyle ':completion:*' max-errors 100 numeric
zstyle ':completetion:*' menu select

autoload -Uz compinit
compinit
# http://www.acm.uiuc.edu/workshops/zsh/prompt/escapes.html

### Prompts
autoload -U colors && colors

export BASE_PS1="%{$fg_bold[green]%}%n@%M %{$fg_bold[blue]%}%10~%{$reset_color%}"
export RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
setopt cdablevars
setopt ignoreeof
setopt interactivecomments
setopt nobanghist
setopt noclobber
#setopt SH_WORD_SPLIT
setopt CORRECT
setopt MENUCOMPLETE
setopt nohup
setopt ALL_EXPORT

# Keyboard ==================================================================================

# Run in vim mode
bindkey -v
export KEYTIMEOUT=1

# History search
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Home key, fixes in urxvt, not xterm
bindkey '^[[1~' beginning-of-line
bindkey -M vicmd '^[[1~' beginning-of-line

# End key
bindkey '^[[4~' end-of-line
bindkey -M vicmd '^[[4~' end-of-line

# Delete key
bindkey '^[[3~' delete-char
bindkey -M vicmd '^[[3~' delete-char

#bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char

# Page Up and Page Down
bindkey '^[[5~' up-history
bindkey -M vicmd '^[[5~' up-history
bindkey '^[[6~' down-history
bindkey -M vicmd '^[[6~' down-history

# Backspace keya
bindkey '^H' backward-delete-char
bindkey -M vicmd '^H' backward-delete-char
bindkey '^?' backward-delete-char
bindkey -M vicmd '^?' backward-char

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

#bindkey '^h' backward-char
#bindkey '^l' forward-char
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# Hate history arrows, use more vimmy history
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '\ek' history-search-backward
bindkey '\ej' history-search-forward
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward

# Make Ctrl+W to erase word
bindkey '^w' backward-kill-word

# Enable reverse search 
#bindkey '^r' history-incremental-search-backward
#bindkey -M vicmd '^r' history-incremental-search-backward

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward
# set up for insert mode too
bindkey -M viins '^r' history-incremental-pattern-search-backward
bindkey -M viins '^f' history-incremental-pattern-search-forward

# Enable exit on Ctrl+D
# bindkey '^d' extended_logout

# Mapping Alt+S to custom function that inserts sudo
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey '\es' insert-sudo

# Insert last word with Alt+. -- cool!
bindkey '\e.' insert-last-word

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ex' edit-command-line

# Make Shift-TAB work as backward complete
bindkey '^[[Z' reverse-menu-complete

# Making vim modes visible with hooks
function zle-line-init zle-keymap-select {
   VIM_ON="%{$fg_bold[red]%}$%{$reset_color%}"
   VIM_OFF="%{$fg_bold[green]%}$%{$reset_color%}"
   PS1="$BASE_PS1 ${${KEYMAP/vicmd/$VIM_ON}/(main|viins)/$VIM_OFF} "
   zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Aliases ==================================================================================

# Set up auto extension stuff
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feg
alias -s sxw=soffice
alias -s doc=soffice
alias -s gz=tar -xzvf # Unp ??
alias -s bz2=tar -xjvf
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

# Normal aliases

# Listing
alias ls='ls --color=auto -F -h'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias la='ls -la'
alias ll='ls -l'
alias sl='ls'

# Vim
alias v='vim'
alias vi='vim'
alias view='vim -R'

# Shell
alias :q='exit'
alias :Q='exit'
alias cls='clear'
alias ..='cd ..'
alias h='history'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'    
alias ln='ln -i'

alias g='git'
alias showclock='watch -n 1 "date +%T | xargs figlet \"Time:\" -c -t"'
alias histgrep='cat ~/.bash_history | grep'
alias todo='vim ~/nfo/TODO.txt'
alias openports='netstat --all --numeric --programs --inet --inet6'
alias webshare='python -m http.server 12721'
alias makepassword='< /dev/urandom tr -dc A-Za-z0-9_ | head -c10 | xargs | cat'
alias ack='ack --color-match="bold red" --color-filename="green"'
alias mstream='mplayer -playlist'
alias grep='grep --colour'
alias fgrep='grep --colour'
alias egrep='egrep --colour'
alias free='free -m'
alias twit='ttytter -ansi -ssl -verify'
alias rss='newsbeuter'
alias up='uptime'

# Programming
alias cmake-release='cmake -DCMAKE_BUILD_TYPE=Release'
alias cmake-debug='cmake -DCMAKE_BUILD_TYPE=Debug'

# Sudoing
alias poweroff='sudo poweroff'
alias mount='sudo mount'
alias umount='sudo umount'
alias scat='sudo cat'
alias svim='sudo vim'
alias reboot='sudo reboot'
alias halt='sudo halt'
alias update='sudo pacman -Suy'

# IPad management
alias mount_ipad_pdf='ifuse --appid com.readdle.PDFExpertIPad /mnt/ipad'
alias mount_ipad_video='ifuse --appid AVPlayerHD.eplayworks.com /mnt/ipad'
alias mount_ipad_djvu='ifuse --appid com.qzyzx.SoleDjVu /mnt/ipad'
alias mount_ipad_root='ifuse --root /mnt/ipad'
alias umount_ipad='umount /mnt/ipad'

# Tools
#alias bindiff='cmp -l file1.bin file2.bin | gawk \'{printf \"%08X %02X %02X\n\", $1, strtonum(0$2), strtonum(0$3)}\''
alias clean_vim_views='rm /home/randy/.vim/view/*'

## Awesome
alias eA='cd ~/.config/awesome && vim rc.lua'
alias cdA='cd ~/.config/awesome'
alias eT='cd ~/.config/awesome/themes/zenburn && vim theme.lua' 

## X Resources Stuff
alias eX='vim ~/.Xresources'
alias XTR='xrdb -merge ~/.Xresources'
 
## Zsh Stuff
alias eZ='vim ~/.zshrc'
alias Z='source ~/.zshrc'
 
## Vim Stuff
alias eV='vim ~/.vimrc'
alias e='vim'

# Misc stuff ==================================================================================
#
unsetopt ALL_EXPORT

# Auto notify on command not found
source /usr/share/doc/pkgfile/command-not-found.zsh


# Colorize mans
man() {
  env \
  LESS_TERMCAP_mb=$(printf "\e[1;34m") \
  LESS_TERMCAP_md=$(printf "\e[1;34m") \
  LESS_TERMCAP_me=$(printf "\e[0m") \
  LESS_TERMCAP_se=$(printf "\e[0m") \
  LESS_TERMCAP_so=$(printf "\e[1;31m") \
  LESS_TERMCAP_ue=$(printf "\e[0m") \
  LESS_TERMCAP_us=$(printf "\e[1;32m") \
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


# Make delete by word parts with Alt+w
tcsh-backward-kill-word() {
  local WORDCHARS="${WORDCHARS:s@/@}"
  zle backward-kill-word
}
zle -N tcsh-backward-kill-word
bindkey '\ew' tcsh-backward-kill-word


# Color on suggestions to display partial match
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==32=00}:${(s.:.)LS_COLORS}")';


# Highlighting package must be installed by pacman
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
#source .zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

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
ZSH_HIGHLIGHT_PATTERNS+=('kill *' 'fg=cyan,bold')
ZSH_HIGHLIGHT_PATTERNS+=('killall *' 'fg=cyan,bold')


# Bell - when command finished
if [ -f ~/.zsh/zbell.sh ]; then
   . ~/.zsh/zbell.sh
fi


