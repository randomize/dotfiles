# Hack for st to make delete work (see st FAQ)
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () { echoti smkx }
    function zle-line-finish () { echoti rmkx }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

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
bindkey -v "^F" history-incremental-search-forward
bindkey -v "^N" down-history
bindkey -v "^P" up-history
bindkey -v "^_" undo

vi-append-x-selection () { RBUFFER=$(xsel -o -p </dev/null)$RBUFFER; }
zle -N vi-append-x-selection
bindkey -M vicmd p vi-append-x-selection


bindkey -M vicmd v edit-command-line

bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)

# Insert last word
bindkey '\e.' insert-last-word

# Mapping Alt+S to custom function that inserts sudo
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey '\es' insert-sudo

# Clear screen <a-c>
bindkey -v '\ec' clear-screen

# do ls++ on <a-l>
bindkey -s '\el' 'l\n'   

# Toggle Ctrl+Z vim
foreground-vi() {
  fg
}
zle -N foreground-vi
bindkey -a '^Z' foreground-vi
bindkey -v '^Z' foreground-vi
