# Zsh rebooted config, zplug powered
# Randy 2016
# TODO: pkgfile hook

# {{{ Managed Plugins =========================================================
# Check if zplug is installed and install it
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug  "plugins/archlinux",                 from:oh-my-zsh
zplug  "plugins/colored-man-pages",         from:oh-my-zsh
zplug  "plugins/colorize",                  from:oh-my-zsh
# zplug  "plugins/compleat",                  from:oh-my-zsh
zplug  "plugins/command-not-found",         from:oh-my-zsh
# zplug  "plugins/common-aliases",            from:oh-my-zsh
# zplug  "plugins/copydir",                   from:oh-my-zsh
# zplug  "plugins/copyfile",                  from:oh-my-zsh
zplug  "plugins/extract",                   from:oh-my-zsh
# zplug  "plugins/history",                   from:oh-my-zsh
# zplug  "plugins/history-substring-search",  from:oh-my-zsh
# zplug  "plugins/man",                       from:oh-my-zsh
# zplug  "plugins/sudo",                      from:oh-my-zsh
# zplug  "plugins/themes",                    from:oh-my-zsh
zplug  "plugins/urltools",                  from:oh-my-zsh
# zplug  "plugins/vscode",                    from:oh-my-zsh
# zplug  "plugins/web-search",                from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"


# Git helper
#zplug "plugins/git",   from:oh-my-zsh, if:"which git"
zplug "plugins/vim-mode", from:oh-my-zsh
#zplug "zsh-users/zsh-syntax-highlighting", defer:2

# export DEFAULT_USER=randy
#zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
# zplug "cusxio/delta-prompt", use:delta.zsh
#zplug "romkatv/powerlevel10k", as:theme, depth:1

# PURE_PROMPT_SYMBOL='$'
# zplug "mafredri/zsh-async", from:github
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

#zplug 'nojhan/liquidprompt'

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


# {{{ Unmanaged plugins & helpers =============================================
# OS detect
[[ -s ~/.zsh/osdetect.zsh ]] && . ~/.zsh/osdetect.zsh

# Zbell
[[ -s ~/.zsh/zbell.sh ]] && . ~/.zsh/zbell.sh

# edit files
[[ -s ~/.zsh/edit.zsh ]] && . ~/.zsh/edit.zsh

# Autojump
[[ -s /etc/profile.d/autojump.zsh ]] && . /etc/profile.d/autojump.zsh

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

# theme tweaks
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time vi_mode)
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='red'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='black'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='012'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='black'
POWERLEVEL9K_VI_INSERT_MODE_STRING='I'
POWERLEVEL9K_VI_COMMAND_MODE_STRING='N'

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

# Shared PATH (NOTE: OS specific see in -specific.zsh files) {{{
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.cargo/bin
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# }}}

# Syntax hightlighting settings
#[[ -s ~/.zsh/highligh-settings.zsh ]] && . ~/.zsh/highligh-settings.zsh
# }}}
#
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Direnv
eval "$(direnv hook zsh)"

