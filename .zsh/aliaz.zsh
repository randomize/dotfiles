# File associations aliases ==================================================================================

# Browser things
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER

# Text things
alias -s txt=$EDITOR
alias -s h=$EDITOR
alias -s cpp=$EDITOR
alias -s java=$EDITOR
alias -s conf=$EDITOR
alias -s PKGBUILD=$EDITOR

# Images
alias -s png=feh
alias -s jpg=feh
alias -s jpeg=feh
alias -s gif=feh
alias -s tiff=feh

# Office
alias -s sxw=soffice
alias -s doc=soffice

# Media
alias -s avi=mpv
alias -s mov=mpv
alias -s mkv=mpv
alias -s mp4=mpv

# Archives
alias -s gz=unp -u
alias -s tgz=unp -u
alias -s bz2=unp -u
alias -s tar=unp -u
alias -s 7z=unp -u
alias -s zip=unp -u
alias -s rar=unp -u

# Other
alias -s pdf=zathura
alias -s djvu=zathura
alias -s torrent=~/bin/download_torrent.sh

# Aliases ==================================================================================

# Listing
alias ls='ls --color=auto -F -h'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias la='ls++ -a'
alias ll='ls++'
alias l='ll'
#alias sl='ls' # let the train help it!
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# Shell
alias :q='exit'
alias :Q='exit'
alias cls='clear'
alias h='history'
alias dh='dirs -v'
alias ccp='rsync -av --stats --info=progress2'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'
alias acp='acp -ig'
alias amv='amv -ig'

alias g='git'
alias gap='git add --patch'

alias clock='watch -n 1 "date +%T | xargs figlet \"Time:\" -c -t"'
alias todo='vim ~/Desktop/TODO.txt'
alias openports='netstat --all --numeric --programs --inet --inet6'
alias webshare='webfsd -p 12721 -d -4 -r ./'
alias webshare2='twistd -no web --path=. --port=12721'
alias webshare3='python -m http.server 12721'
alias makepassword='< /dev/urandom tr -dc A-Za-z0-9_ | head -c10 | xargs | cat'
alias makenumber='< /dev/urandom tr -dc 0-9 | head -c16 | xargs | cat'
alias ag='ag --color-match 38\;5\;197 --color-line-number 38\;5\;110 --color-path 38\;5\;215\;4'
alias ack=ag
alias mstream='mplayer -playlist'
alias grep='grep --colour'
alias fgrep='grep --colour'
alias egrep='egrep --colour'
alias free='free -m'
alias htop='htop -d 2'
alias fehdir='feh -g 640x480 -d -S filename'

# Programming
alias cmake-release='cmake -DCMAKE_BUILD_TYPE=Release'
alias cmake-debug='cmake -DCMAKE_BUILD_TYPE=Debug'

# Tools
#alias bindiff='cmp -l file1.bin file2.bin | gawk \'{printf \"%08X %02X %02X\n\", $1, strtonum(0$2), strtonum(0$3)}\''
alias vim-clean-views='rm -f ~/.vim/view/*'
alias sdcv='sdcv'
# alias sdcv='sdcv --color'
alias sdc='sdcv -u "LingvoUniversal (En-Ru)" --color'
alias cgdb='cgdb -- -nx -x ~/.cgdbinit '
alias ccat='pygmentize -f 256 -g -O style=monokai,linenos=1'
alias sniff-flv='sudo ngrep -d any '.flv'  port 80'

## Editing aliases
alias eZ='vim ~/.zshrc && source ~/.zshrc'
alias eV='vim ~/.config/nvim/init.vim'
alias eT='vim ~/.tmux.conf'

## Dot helpers
# alias ..='cd ..'
# alias ...='cd ../..'
# alias ....='cd ../../..'
# alias .....='cd ../../../..'
# alias ......='cd ../../../../..'

## Editors aliases
alias vim='nvim'
alias e='vim'
alias v='vim'
alias vi='vim'
alias view='vim -R'


