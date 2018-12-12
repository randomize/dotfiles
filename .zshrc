# Zsh rebooted config, zplug powered
# Randy 2016
# TODO: pkgfile hook

# Support for evaluating a function on startup
# if [[ $1 == eval ]]
# then
#    "$@"
#    set --
# fi


# {{{ Managed Plugins =========================================================
# Check if zplug is installed and install it
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh


# Git helper
zplug "plugins/git",   from:oh-my-zsh, if:"which git"
zplug "plugins/vim-mode", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# export DEFAULT_USER=randy
# zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
# zplug "cusxio/delta-prompt", use:delta.zsh

# PURE_PROMPT_SYMBOL='$'
# zplug "mafredri/zsh-async", from:github
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zplug 'nojhan/liquidprompt'

# Z is new Autojump
zplug "rupa/z", use:z.sh
zplug "rimraf/k"
zplug "djui/alias-tips"
zplug "Tarrasch/zsh-bd"

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

function zle-keymap-select zle-line-init
{
  case $KEYMAP in
    vicmd)
      # PROMPT="${PROMPT[1,-2]}8"
      P="${PROMPT/\[/<}"
      PROMPT="${P/\]/>}"
      ;;
    viins|main)
      # PROMPT="${PROMPT[1,-2]} "
      P="${PROMPT/</[}"
      PROMPT="${P/>/]}"
      ;;
  esac
  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-keymap-select

# {{{ Unmanaged plugins & helpers =============================================
# OS detect
[[ -s ~/.zsh/osdetect.zsh ]] && . ~/.zsh/osdetect.zsh

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
#export HISTORY_IGNORE="(cd.*|ls)"
#export HISTORY_IGNORE='([bf]g *|cd ..|l[alsh]#( *)#|less *|vim# *)'
export HISTORY_IGNORE="(ls *|cd *|git ci -m *)"
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
# Timestamp history
setopt EXTENDED_HISTORY
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


# pkgfile
[[ -s  /usr/share/doc/pkgfile/command-not-found.zsh ]] && . /usr/share/doc/pkgfile/command-not-found.zsh

# Fasd
[[ -s `which fasd` ]] && eval "$(fasd --init auto)"

[ -s "/home/randy/.dnx/dnvm/dnvm.sh" ] && . "/home/randy/.dnx/dnvm/dnvm.sh" # Load dnvm

# PATH {{{
export PATH=$PATH:/home/randy/.cargo/bin
export PATH=$PATH:/home/randy/bin
# }}}

# Syntax hightlighting settings
[[ -s ~/.zsh/highligh-settings.zsh ]] && . ~/.zsh/highligh-settings.zsh
# }}}
