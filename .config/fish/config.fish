set -gx EDITOR nvim

direnv hook fish | source
starship init fish | source

. "$HOME/.config/fish/aliases.fish"
