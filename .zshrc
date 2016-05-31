# Zsh rebooted config, zplug powered
# Randy 2016

# Support for evaluating a function on startup
if [[ $1 == eval ]]
then
   "$@"
   set --
fi


# {{{ Managed Plugins =========================================================
# Zplug is used - a plugin manager for zsh
# git clone https://github.com/b4b4r07/zplug ~/.zplug

source ~/.zplug/zplug

# Git helper
zplug "plugins/git",   from:oh-my-zsh, if:"which git"

# Syntax highlighting bundle.
zplug "zsh-users/zsh-syntax-highlighting", nice:10

# Load the theme.
export DEFAULT_USER=randy
zplug "bhilburn/powerlevel9k", of:powerlevel9k.zsh-theme

zplug "rimraf/k"
zplug "djui/alias-tips"
export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡  '

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# }}}

# {{{ Unmanaged plugins & helpers =============================================
# OS detect
[[ -s ~/.zsh/osdetect.zsh ]] && . ~/.zsh/osdetect.zsh

# Dircolors
[[ -s ~/.dircolors ]] && eval `dircolors -b $HOME/.dircolors`

# Zbell
[[ -s ~/.zsh/zbell.sh ]] && . ~/.zsh/zbell.sh

# back dir
[[ -s ~/.zsh/bd/bd.zsh ]] && . ~/.zsh/bd/bd.zsh

# Autojump
[[ -s /etc/profile.d/autojump.zsh ]] && . /etc/profile.d/autojump.zsh

## Todos
alias t='python2 /mnt/data/t/t.py --task-dir ~/tasks --list tasks'

# }}}

# {{{ Aliases =================================================================
[[ -s ~/.zsh/aliaz.zsh ]] && . ~/.zsh/aliaz.zsh
# }}}

# {{{ Keyboard =================================================================
[[ -s ~/.zsh/keyboars.zsh ]] && . ~/.zsh/keyboars.zsh
# }}}

# {{{ Settings ================================================================

# History
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt extended_history # Timestamp history
setopt share_history
setopt inc_append_history

# Syntax hightlighting settings
[[ -s ~/.zsh/highligh-settings.zsh ]] && . ~/.zsh/highligh-settings.zsh
# }}}

# COMPLETION SETTINGS: add custom completion scripts
fpath=(~/.zsh/completion $fpath) 

# compsys initialization
autoload -U compinit
compinit
 
# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2

# {{{ OS specific stuff ============================================================

if [[ "$OSX" == "1" ]]
then
    [[ -s ~/.zsh/osx-specific.zsh ]] && . ~/.zsh/osx-specific.zsh
elif [[ "$LINUX" == "1" ]]
then
    [[ -s ~/.zsh/linux-specific.zsh ]] && . ~/.zsh/linux-specific.zsh
fi

# }}}

# {{{ Functions =================================================================
[[ -s ~/.zsh/functs.zsh ]] && . ~/.zsh/functs.zsh
# }}}

