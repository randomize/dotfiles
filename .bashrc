
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

# Defaults
export BROWSER=firefox
export EDITOR=nvim
export TERMINAL=kitty

# Dotnet core
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

# Stuff
eval "$(direnv hook bash)"
eval "$(starship init bash)"
# export PATH="/home/jethro/.pyenv/bin:$PATH"
# export PATH="/home/jethro/.poetry/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# FzF
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
