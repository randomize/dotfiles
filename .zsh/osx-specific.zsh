# Scripts, aliases and helpers for OSX
#
# {{{ Aliases =============================================
alias update='brew update && brew upgrade && brew cleanup'
alias ls='gls --color=auto -F -h'

function repostats()
{
    gfind . -type f -name '*.*' -not -path "./.git/*" | gsed 's|.*\.||' | gsort | guniq -c | sort -n
}

# {{{ Paths =============================================

# Brew
export PATH="/usr/local/bin:$PATH"

# Rustup
export PATH="$HOME/.cargo/bin:$PATH"


# {{{ Plugins =============================================
# Dircolors
[[ -s ~/.dircolors ]] && eval `gdircolors -b $HOME/.dircolors`
# Autojump (brew install autojump)
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}
