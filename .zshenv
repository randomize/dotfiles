# Setup defaukts
export BROWSER=firefox
export EDITOR=nvim

# Enable anti aliasing in java programs
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1

# Set path for gtk config
export GTK2_RC_FILES="$HOME/.gtkrc-2.0" 

# export PAGER="most -s"
export LESS="-i -s -R"
export LESSCHARSET='utf-8'
export PAGER="less"
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

export TERMINAL="urxvtc"

# Fonts in old aps
export GDK_USE_XFT=1
export QT_XFT=true

# Vim config dev personal settings
export bully_dev="eugene"

# Rust
export RUST_SRC_PATH="/usr/src/rust/src"

export PATH=$PATH:/home/randy/.gem/ruby/2.4.0/bin
