# My utils in path
export PATH=$PATH:$HOME/bin

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
