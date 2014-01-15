# Created by newuser for 5.0.2
#


# Zsh options

# Coloring is fun
fg_black=%{$'\e[0;30m'%}
fg_red=%{$'\e[0;31m'%}
fg_green=%{$'\e[0;32m'%}
fg_brown=%{$'\e[0;33m'%}
fg_blue=%{$'\e[0;34m'%}
fg_purple=%{$'\e[0;35m'%}
fg_cyan=%{$'\e[0;36m'%}
fg_lgray=%{$'\e[0;37m'%}
fg_dgray=%{$'\e[1;30m'%}
fg_lred=%{$'\e[1;31m'%}
fg_lgreen=%{$'\e[1;32m'%}
fg_yellow=%{$'\e[1;33m'%}
fg_lblue=%{$'\e[1;34m'%}
fg_pink=%{$'\e[1;35m'%}
fg_lcyan=%{$'\e[1;36m'%}
fg_white=%{$'\e[1;37m'%}
#Text Background Colors
bg_red=%{$'\e[0;41m'%}
bg_green=%{$'\e[0;42m'%}
bg_brown=%{$'\e[0;43m'%}
bg_blue=%{$'\e[0;44m'%}
bg_purple=%{$'\e[0;45m'%}
bg_cyan=%{$'\e[0;46m'%}
bg_gray=%{$'\e[0;47m'%}
#Attributes
at_normal=%{$'\e[0m'%}
at_bold=%{$'\e[1m'%}
at_italics=%{$'\e[3m'%}
at_underl=%{$'\e[4m'%}
at_blink=%{$'\e[5m'%}
at_outline=%{$'\e[6m'%}
at_reverse=%{$'\e[7m'%}
at_nondisp=%{$'\e[8m'%}
at_strike=%{$'\e[9m'%}
at_boldoff=%{$'\e[22m'%}
at_italicsoff=%{$'\e[23m'%}
at_underloff=%{$'\e[24m'%}
at_blinkoff=%{$'\e[25m'%}
at_reverseoff=%{$'\e[27m'%}
at_strikeoff=%{$'\e[29m'%}

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# Variables
export EDITOR="vim"
#export PAGER="most -s"
export PATH="${PATH}:${HOME}/bin"
eval `dircolors -b`

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

#export PROMPT="%n@%m %c %# >> "
#PS1="%{$fg[blue]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
#
#autoload colors zsh/terminfo
#if [[ "$terminfo[colors]" -ge 8 ]]; then
#   colors
#fi
#for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
#   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
#   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
#   (( count = $count + 1 ))
#done
#PR_NO_COLOUR="%{$terminfo[sgr0]%}"

#
#
export PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}$ "
export RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
setopt cdablevars
setopt ignoreeof
setopt interactivecomments
setopt nobanghist
setopt noclobber
setopt SH_WORD_SPLIT
setopt CORRECT
setopt EXTENDED_HISTORY # Timestamp history
setopt MENUCOMPLETE
setopt nohup
setopt ALL_EXPORT

# History search
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Run in vim mode
bindkey -v

# Aliases
if [ -f ~/.zshrc ]; then
   . ~/.zsh_alias
fi

# PATH=/usr/share/perl5/vendor_perl/auto/share/dist/Cope:$PATH
# TZ="America/Los_Angeles"
# HOSTNAME="`hostname`"
# LC_ALL='en_US.UTF-8'
# LANG='en_US.UTF-8'
# LC_CTYPE=C

unsetopt ALL_EXPORT

# Auto notify on command not found
source /usr/share/doc/pkgfile/command-not-found.zsh
