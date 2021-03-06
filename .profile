# My utils in path
export PATH="$PATH:$HOME/bin"

# Mostly for Haskell stack binaries
export PATH="$HOME/.local/bin:$PATH"

# Rust in path
export PATH=$PATH:$HOME/.cargo/bin
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Go in path
export PATH="$PATH:$HOME/go/bin"

# Vim config dev personal settings
export bully_dev="eugene"

# Node.js stuff (tiddlywiki, appcenter, ghs - github search)
export PATH=$PATH:$HOME/.node_modules/bin
export npm_config_prefix=~/.node_modules

# NNN
export NNN_BMS='d:~/Documents;D:~/Downloads/'
export NNN_SSHFS="sshfs -o follow_symlinks"        # make sshfs follow symlinks on the remote
export NNN_COLORS="2136"                           # use a different color for each context
export NNN_TRASH=1                                 # trash (needs trash-cli) instead of delete
# export 
