# Scripts, aliases and helpers for OSX
#
# {{{ Aliases =============================================

function update()
{
    brew update
    brew upgrade
    brew cask upgrade
    brew cask list | xargs brew cask upgrade
    brew cleanup
}

alias ls='gls --color=auto -F -h'

function repostats()
{
    gfind . -type f -name '*.*' -not -path "./.git/*" | gsed 's|.*\.||' | gsort | guniq -c | sort -n
}

function bright()
{
    ~/Documents/ddcctl-master/ddcctl -b $1 -d 1
    ~/Documents/ddcctl-master/ddcctl -b $1 -d 2
    ~/Documents/ddcctl-master/ddcctl -b $1 -d 3
}
# }}}

# {{{ Paths =============================================

# Brew
export PATH="/usr/local/bin:$PATH"

# Rustup
export PATH="$HOME/.cargo/bin:$PATH"

# Python
#export PATH=$PATH:~/Library/Python/3.7/bin

# Ruby (brew overrides system)
#export PATH=/usr/local/opt/ruby/bin:$PATH
#export PATH=$PATH:~/.gem/ruby/2.3.0/bin
# Rbenv init
eval "$(rbenv init -)"
export PATH=$PATH:~/.gem/bin

# Perl (perlbrew overrides system)
#eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
# Perlbrew : https://perlbrew.pl/
source ~/perl5/perlbrew/etc/bashrc

# Adb (needs Android sdk installed)
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# }}}

# {{{ Plugins =============================================

# Dircolors
[[ -s ~/.dircolors ]] && eval `gdircolors -b $HOME/.dircolors`

# Autojump (brew install autojump)
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

# FZF (run install first to generate ~/.fzf.zsh file!)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# }}}
