#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# setup my preferables
export BROWSER=firefox
export EDITOR=vim

# Set path for gtk config
export GTK2_RC_FILES="$HOME/.gtkrc-2.0" 

# Load settings from X
xrdb -merge ~/.Xresources 

# Set layouts and my lovely capslock =)
setxkbmap -layout "us, ru" -option "grp:caps_toggle"
setxkbmap -option terminate:ctrl_alt_bksp

# Set repeat rate
xset r rate 400 80

# Set desktop bg
feh  --bg-scale /home/randy/Pictures/wall.jpg &

# make terminus visible for xfontsel and clients
xset +fp /usr/share/fonts/local

# Disable screen turn off
xset s off

# Start xxkb
# xxkb &

# Pulsdaudio helper icon
# pasystray &

# Clipboard manager
parcellite &

# Composition
compton -b

# Set wacom buttons correctly
xsetwacom --set "Wacom Intuos3 9x12 stylus" Button 2 "button +3"
xsetwacom --set "Wacom Intuos3 9x12 stylus" Button 3 "button +2"

# File manager
#thunar --daemon

# Lightons script
/home/randy/bin/lightsOn.sh &

# Start xxkb
urxvtd &

# Easystroke
# easystroke &

# Mounting provider
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Ssh agent
eval `ssh-agent -s`

# Mpd
/usr/bin/mpd

exec awesome
# exec xmonad
# exec i3 -V >> /tmp/i3log 2>&1
# exec startfluxbox
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

