# helper function for dots editing (thanks to ssh0 at github.com/ssh0/dotfiles)
#

# edit configuration file by $EDITOR (vim).
function _ec() {
  local cmd alis
  if [[ ! -e "$2" ]]; then
    alias "e-$1::NEW"="echo \"File '$2' doesn't exist. \"; \
                     confirm y \"Create new one?\" && $EDITOR '$2'"
    return -1
  fi

  alis="$1"
  if [[ -n "$3" ]]; then
    local target
    target="$2"
    cmd="$3"
    shift 3
    cmd="$cmd '$target' "$@""
  elif [[ -f "$2" ]]; then
    cmd="$EDITOR '$2'"
  elif [[ -d "$2" ]]; then
    cmd="ranger --cmd='cd '$2''"
    # cmd="builtin cd '$2'; ls"
  fi
  alias "e-${alis}"="$cmd"
  return 0
}

# _ec alias      ${ZSH_ROOT}/functions/alias.zsh
# _ec completion ${ZSH_ROOT}/completions
# _ec compton    ~/.config/compton/compton.conf
# _ec dotlink    ~/.dotfiles/dotlink
# _ec dotrc      ~/.dotfiles/dotrc
# _ec env        ${ZSH_ROOT}/functions/environment.zsh
# _ec functions  ${ZSH_ROOT}/functions
# _ec history    ${ZSH_ROOT}/history
# _ec latexmk    ~/.latexmkrc
# _ec luakit     ~/.config/luakit
_ec mplayer    ~/.mplayer/config
_ec mpd        ~/.config/mpd/mpd.conf
_ec mpv        ~/.config/mpv/mpv.conf
_ec mutt       ~/.muttrc
_ec nvim       ~/.config/nvim/init.vim
_ec ncmpcpp    ~/.ncmpcpp/bindings
_ec awesome    ~/.config/awesome/rc.lua
# _ec plug       ~/.config/nvim/plug.vim
# _ec prompt     ${ZSH_ROOT}/functions/prompt.zsh
_ec ranger     ~/.config/ranger/rc.conf
_ec ranger.d   ~/.config/ranger
# _ec s          ~/bin/s_provider
# _ec tig        ~/.tigrc
_ec tmux       ~/.tmux.conf
# _ec turses     ~/.turses/config
_ec vim        ~/.vimrc
# _ec vimcolor   ~/gitrepo/easy-reading.vim/colors/easy-reading.vim
# _ec vimperator ~/.vimperatorrc
# _ec w3m        ~/.w3m/config
# _ec w3m-keymap ~/.w3m/keymap
# _ec websearch  ~/Workspace/python/web_search/websearch/config.py
# _ec xdefaults  ~/.Xdefaults
# _ec xmodmap    ~/.Xmodmap
# _ec xmonad     ~/.xmonad/xmonad.hs
_ec xresources ~/.Xresources
# _ec zplug      ${ZSH_ROOT}/functions/zplug.zsh
_ec zshrc      ~/.zshrc
# _ec zgen       ${ZSH_ROOT}/functions/zgen.zsh

unfunction _ec
