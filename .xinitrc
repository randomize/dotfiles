#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
   for rcd in /etc/X11/xinit/xinitrc.d/* ; do
      [ -x "$rcd" ] && . "$rcd"
   done
   unset rcd
fi

# exec gnome-session
# return

# Manually create
mkdir .cache/rtorrent_session/

# Load settings from X
xrdb -merge ~/.Xresources

# Layout manager
kbdd &

# Set layouts and no capslock
setxkbmap -layout "dvp, us, ru" -option "grp:shifts_toggle"

# Make Caps Lock a Control key
setxkbmap -option ctrl:nocaps 

# Shift+NumLock shortcut toggle mouse keys
setxkbmap -option "keypad:pointerkeys"

# Right alt is compose
setxkbmap -option "compose:ralt"

# Turn on c-a-backspace
setxkbmap -option terminate:ctrl_alt_bksp

# Special mappings (see .Xmodmap file)
xmodmap .Xmodmap
xcape -e '0x1234=Return;Control_L=Escape'

# Set repeat rate
xset r rate 400 80

# make terminus visible for xfontsel and clients
xset +fp /.fonts
xset +fp /usr/share/fonts/local

# Rebuild xdg menu for awesome
xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu > ~/.config/awesome/archmenu.lua 

# Conky
( ( sleep 3 && conky ) & )

# Clipboard manager
( ( sleep 3 && (copyq &) ) & )

# Clipboard manager
( ( sleep 3 && (goldendict &) ) & )

# Clipboard manager
( ( sleep 3 && (pasystray &) ) & )

# Composition
compton -b

# Set wacom buttons correctly
xsetwacom --set "Wacom Intuos3 9x12 stylus" Button 2 "button +3"
xsetwacom --set "Wacom Intuos3 9x12 stylus" Button 3 "button +2"
xsetwacom --set "Wacom Intuos3 9x12 stylus" "StripLeftDown" "0"                                                                                                                                            ~/rdev/cpp/clang-ast
xsetwacom --set "Wacom Intuos3 9x12 stylus" "StripRightUp" "0"                                                                                                                                             ~/rdev/cpp/clang-ast
xsetwacom --set "Wacom Intuos3 9x12 stylus" "StripRightDown" "0"                                                                                                                                           ~/rdev/cpp/clang-ast
xsetwacom --set "Wacom Intuos3 9x12 stylus" "StripLeftUp" "0"


# Start urxvt daemon (quiet, forked, only for this X session)
urxvtd -q -f -o

# Screensaver
xscreensaver -no-splash -display :0.0 &

# Monitors setup
xrandr --dpi 100
xrandr --output VGA1 --off
xrandr --output HDMI2 --primary
xrandr --output DP1 --left-of HDMI2

# Map wacom
xsetwacom --set "Wacom Intuos3 9x12 stylus" MapToOutput "HDMI2" 
xsetwacom --set "Wacom Intuos3 9x12 eraser" MapToOutput "HDMI2" 

# Disable screen turn off
# xset s off
# Lightons script
/home/randy/bin/lightsOn.sh &


# Mpd
( ( sleep 4 && /usr/bin/mpd) & )

# layout indicator
( ( sleep 4 && /usr/bin/sbxkb ) & )

# DDC controlled brightness
( ( sleep 4 && /home/randy/bin/ddc-bright ) & )

# ALSA 2 JACK - MIDI daemon
# ( ( sleep 4 && /usr/bin/a2jmidid -e) & )

# Awesome
exec awesome
