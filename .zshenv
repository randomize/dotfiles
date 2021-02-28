# Setup defaults

# Its ungoogled so its fine
export BROWSER=chromium
# Neovim
export EDITOR=nvim

# Enable anti aliasing in java programs
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1

# Set path for gtk config
export GTK2_RC_FILES="$HOME/.gtkrc-2.0" 

# QT themes
export QT_STYLE_OVERRIDE=adwaita

# export PAGER="most -s"
export LESS="-i -s -R"
export LESSCHARSET='utf-8'
export PAGER="less"
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

export TERMINAL="st"

# Fonts in old aps
export GDK_USE_XFT=1
export QT_XFT=true

# Vim config dev personal settings
export bully_dev="eugene"

# Dotnet core
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

# Ruby
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem

# Go
export PATH="$PATH:$HOME/go/bin"

# Rider+Unity hack to avoid .NETFramework,Version=v4.7.1 not found issue...
export FrameworkPathOverride=/etc/mono/4.5

# Perl
source ~/perl5/perlbrew/etc/bashrc


