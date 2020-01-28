# Scripts, aliases and helpers for Linux (Arch distro)


# {{{ Aliases ==================================================
alias update='sudo pacman -Suy'
alias ls='ls --color=auto -F -h'
alias rm='rm -I'

alias pa='pacman'
alias ya='yay'

# Package management
alias update='sudo pacman -Suy'
alias pacinst='sudo pacman -S'
alias pacexpl='sudo pacman -D --asexplicit'

# Editing aliases
alias eA='vim ~/.config/awesome/rc.lua'
alias eX='vim ~/.Xresources && xrdb -merge ~/.Xresources'
alias eS='vim ~/nfo/setup.txt'
alias eP='vim ~/nfo/paks.txt'
alias eI='vim ~/.xinitrc'

# Virtual Box
alias vb-macos='VBoxManage startvm "VM Mac OS Mavericks"'
alias vb-windows='VBoxManage startvm "Window 8"'
alias vb-xp='VBoxManage startvm "WinXP"'

# IPad management
alias mount-ipad-pdf='ifuse --appid com.readdle.PDFExpertIPad /mnt/ipad && cd /mnt/ipad'
alias mount-ipad-video='ifuse --appid AVPlayerHD.eplayworks.com /mnt/ipad && cd /mnt/ipad'
alias mount-ipad-djvu='ifuse --appid com.qzyzx.SoleDjVu /mnt/ipad && cd /mnt/ipad'
alias mount-ipad-root='ifuse --root /mnt/ipad && cd /mnt/ipad'
alias umount-ipad='cd ~ && umount /mnt/ipad'
alias mount-mac='sudo sshfs  randy@10.10.10.105:/ /mnt/macos'

# Functs
function repostats()
{
    find . -type f -name '*.*' -not -path "./.git/*" | sed 's|.*\.||' | sort | uniq -c | sort -n
}

# }}}

# {{{ Misc =====================================================
# Dircolors
[[ -s ~/.dircolors ]] && eval `dircolors -b $HOME/.dircolors`

# Load dnvm
[[ -s "/home/randy/.dnx/dnvm/dnvm.sh" ]] && . "/home/randy/.dnx/dnvm/dnvm.sh"

# Fzf
[[ -s /usr/share/fzf/key-bindings.zsh ]] && . /usr/share/fzf/key-bindings.zsh
[[ -s /usr/share/fzf/key-completion.zsh ]] && . /usr/share/fzf/key-completion.zsh

## Todos
alias t='python /mnt/data/t/t.py --task-dir ~/tasks --list tasks'
