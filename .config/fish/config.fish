set -gx EDITOR nvim

direnv hook fish | source
starship init fish | source

. "$HOME/.config/fish/aliases.fish"


# My custom binding to ctrl+t to search including ignored files
function __fzf_search_current_dir_everything
    set -lx fzf_fd_opts -H -I
    __fzf_search_current_dir
end
function __fzf_search_current_dir_dirs
    set -lx fzf_fd_opts -H -I --type=d
    __fzf_search_current_dir
end

bind --mode insert \ct __fzf_search_current_dir_everything
bind --mode insert \ec __fzf_search_current_dir_dirs

function urlencode
  perl -MURI::Escape -le "print uri_escape('$argv')"
end
function urldecode
  perl -MURI::Escape -le "print uri_unescape('$argv')"
end
