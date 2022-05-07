
# {{{ Managed Plugins =========================================================
# Check if zplug is installed and install it
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug "plugins/archlinux",                 from:oh-my-zsh
zplug "plugins/colored-man-pages",         from:oh-my-zsh
zplug "plugins/colorize",                  from:oh-my-zsh
zplug "plugins/command-not-found",         from:oh-my-zsh
zplug "plugins/extract",                   from:oh-my-zsh
zplug "plugins/urltools",                  from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "rimraf/k"
zplug "djui/alias-tips"
zplug "Tarrasch/zsh-bd"
zplug "jeffreytse/zsh-vi-mode"

export ZSH_PLUGINS_ALIAS_TIPS_TEXT='  '

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
# zplug load --verbose
zplug load

# }}}


# {{{ Unmanaged plugins & helpers =============================================
# OS detect
[[ -s ~/.zsh/osdetect.zsh ]] && . ~/.zsh/osdetect.zsh

# Zbell
[[ -s ~/.zsh/zbell.sh ]] && . ~/.zsh/zbell.sh

# edit files
[[ -s ~/.zsh/edit.zsh ]] && . ~/.zsh/edit.zsh

# }}}

# {{{ Aliases =================================================================
[[ -s ~/.zsh/aliaz.zsh ]] && . ~/.zsh/aliaz.zsh
# }}}

# {{{ Keyboard =================================================================
[[ -s ~/.zsh/keyboars.zsh ]] && . ~/.zsh/keyboars.zsh
# }}}

# {{{ Settings ================================================================

# History
#export HISTORY_IGNORE='([bf]g *|cd ..|l[alsh]#( *)#|less *|vim# *)'
export HISTORY_IGNORE="(ls *|cd *|git *)"
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP


# COMPLETION SETTINGS: add custom completion scripts
fpath=(~/.zsh/completion $fpath) 

# compsys initialization
autoload -U compinit
compinit

autoload -z edit-command-line 
zle -N edit-command-line
# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=4

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


# Shared PATH (NOTE: OS specific see in -specific.zsh files) {{{
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH="$HOME/.pyenv/bin:$PATH"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# }}}

# Pyenv, Direnv, Zoxide, Starship
[[ -s `which pyenv` ]] && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"
[[ -s `which direnv` ]] && eval "$(direnv hook zsh)"
[[ -s `which zoxide` ]] && eval "$(zoxide init zsh)"
[[ -s `which starship` ]] && eval "$(starship init zsh)"
