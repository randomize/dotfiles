# This is configuration file for zsh-highlight
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets )
#
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=009'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=197,bold' # for, if, do, done etc'

ZSH_HIGHLIGHT_STYLES[alias]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=009'
ZSH_HIGHLIGHT_STYLES[path]='fg=214,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=214,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=074,bold'                 # *.txt
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=115'          # -h
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=114'          # --help

ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=081'          # `foo`
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=222'        # 'foo'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=215'        # "foo"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=191'        # $'foo'

ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=191' # $foo in ""
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=210'   # \n in ""
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=210'   # \n in $''

ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=white,bold'

ZSH_HIGHLIGHT_STYLES[comment]='fg=240'

ZSH_HIGHLIGHT_PATTERNS+=('rm'        'fg=232,bold,bg=197')
ZSH_HIGHLIGHT_PATTERNS+=('kill'      'fg=232,bold,bg=197')
ZSH_HIGHLIGHT_PATTERNS+=('pkill'     'fg=232,bold,bg=197')
ZSH_HIGHLIGHT_PATTERNS+=('killall'   'fg=232,bold,bg=197')
ZSH_HIGHLIGHT_PATTERNS+=('git reset' 'fg=232,bold,bg=197')
ZSH_HIGHLIGHT_PATTERNS+=('\|'      'fg=197,bold')

# Highlight MAC addresses, IPs.
ZSH_HIGHLIGHT_PATTERNS+=('[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]' 'fg=yellow')
ZSH_HIGHLIGHT_PATTERNS+=(' [0-9]##.[0-9]##.[0-9]##.[0-9]##' 'fg=yellow')

# Highlight complex redirection signes.
ZSH_HIGHLIGHT_PATTERNS+=('[0-9]#[<>]&[-!|0-9]#' 'fg=blue')
ZSH_HIGHLIGHT_PATTERNS+=('[<>]([<>]|)([|!]|)' 'fg=blue')
ZSH_HIGHLIGHT_PATTERNS+=('&[|!]' 'fg=blue')
