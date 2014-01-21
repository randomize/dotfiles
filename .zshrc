# Created by newuser for 5.0.2
#


# Zsh options

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

# Variables
export EDITOR="vim"
#export PAGER="most -s"
export PATH="${PATH}:${HOME}/bin:${HOME}/android/sdk/tools:${HOME}/android/sdk/platform-tools"
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

export BASE_PS1="%{$fg_bold[green]%}%n@%M %{$fg_bold[blue]%}%10~%{$reset_color%}"
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
#bindkey '^[[3~' delete-char

# Page Up and Page Down
bindkey '^[[5~' up-history
bindkey -M vicmd '^[[5~' up-history
bindkey '^[[6~' down-history
bindkey -M vicmd '^[[6~' down-history

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

bindkey '^?' backward-delete-char
bindkey -M vicmd '^?' backward-char

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
bindkey '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# Enable exit on Ctrl+D
# bindkey '^d' extended_logout

# Making vim modes visible with hooks
function zle-line-init zle-keymap-select {
   VIM_ON="%{$fg_bold[red]%}$%{$reset_color%}"
   VIM_OFF="%{$fg_bold[green]%}$%{$reset_color%}"
   PS1="$BASE_PS1 ${${KEYMAP/vicmd/$VIM_ON}/(main|viins)/$VIM_OFF} "
   zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


# Aliases
if [ -f ~/.zshrc ]; then
   . ~/.zsh_alias
fi

unsetopt ALL_EXPORT

# Auto notify on command not found
source /usr/share/doc/pkgfile/command-not-found.zsh

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

# Systemd in archlinux
user_commands=(
  list-units is-active status show help list-unit-files
  is-enabled list-jobs show-environment)

sudo_commands=(
  start stop reload restart try-restart isolate kill
  reset-failed enable disable reenable preset mask unmask
  link load cancel set-environment unset-environment)

for c in $user_commands; do; alias sc-$c="systemctl $c"; done
for c in $sudo_commands; do; alias sc-$c="sudo systemctl $c"; done


# Make delete by word parts with Alt+w
tcsh-backward-kill-word() {
  local WORDCHARS="${WORDCHARS:s@/@}"
  zle backward-kill-word
}
zle -N tcsh-backward-kill-word
bindkey '\ew' tcsh-backward-kill-word





