set -gx EDITOR nvim

set -gx fish_path ~/.config/fish/
set -gx fisher_path ~/.config/fish/fisher_plugins
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    source $file
end


source "$fish_path/aliases.fish"
#source "$fish_path/functions/helpers.fish"

set fzf_fd_opts --hidden --exclude=.git

# My custom binding to ctrl+t to search including ignored files
# Fzf.fish broke the way how they do bindings....
#function __fzf_search_current_dir_everything
#    set -lx fzf_fd_opts -H -I
#    __fzf_search_current_dir
#end
#function __fzf_search_current_dir_dirs
#    set -lx fzf_fd_opts -H -I --type=d
#    __fzf_search_current_dir
#end
#
#bind --mode insert \ct __fzf_search_current_dir_everything
#bind --mode insert \ec __fzf_search_current_dir_dirs

function urlencode
  perl -MURI::Escape -le "print uri_escape('$argv')"
end
function urldecode
  perl -MURI::Escape -le "print uri_unescape('$argv')"
end

direnv hook fish | source
starship init fish | source
zoxide init fish | source

# pyenv (set these once interactively)
# set -Ux PYENV_ROOT $HOME/.pyenv
# set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
##
status is-interactive; and pyenv init --path | source

