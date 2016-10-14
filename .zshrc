# Zsh rebooted config, zplug powered
# Randy 2016

# Support for evaluating a function on startup
if [[ $1 == eval ]]
then
   "$@"
   set --
fi


# {{{ Managed Plugins =========================================================
# Check if zplug is installed and install it
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh


# Git helper
zplug "plugins/git",   from:oh-my-zsh, if:"which git"

# Syntax highlighting bundle.
zplug "zsh-users/zsh-syntax-highlighting", nice:10

# Load the theme.
export DEFAULT_USER=randy
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

zplug "rimraf/k"
zplug "djui/alias-tips"
zplug "Tarrasch/zsh-bd"

export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡  '

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
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

# edit files
[[ -s ~/.zsh/edit.zsh ]] && . ~/.zsh/edit.zsh

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

autoload -z edit-command-line 
zle -N edit-command-line
# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=4

# theme tweaks
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time vi_mode)
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='yellow'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='white'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='014'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='white'
POWERLEVEL9K_VI_INSERT_MODE_STRING='\UE858' # 
POWERLEVEL9K_VI_COMMAND_MODE_STRING='\UE801' # 

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


[ -s "/home/randy/.dnx/dnvm/dnvm.sh" ] && . "/home/randy/.dnx/dnvm/dnvm.sh" # Load dnvm
