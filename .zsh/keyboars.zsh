# Hack for st
function zle-line-init () { echoti smkx }
function zle-line-finish () { echoti rmkx }
zle -N zle-line-init
zle -N zle-line-finish

# Multi-terminal support
autoload zkbd
# Vim Keys by default
bindkey -v
export KEYTIMEOUT=1
[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
[[ ! -f ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]] && zkbd
source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}

[[ -n ${key[Backspace]} ]]&& bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]]   && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]]     && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]]   && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]]   && bindkey -v "${key[Delete]}" delete-char
[[ -n ${key[End]} ]]      && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]]       && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]]     && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]]     && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]]    && bindkey "${key[Right]}" forward-char

bindkey -v "^R" history-incremental-search-backward
bindkey -v "^N" down-history
bindkey -v "^P" up-history
bindkey -v "^_" undo


bindkey -M vicmd v edit-command-line

