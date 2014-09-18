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



# Load settings from X
xrdb -merge ~/.Xresources 

xrandr --dpi 88 

# Set layouts and no capslock
#setxkbmap -layout "us, ru" -option "grp:caps_toggle"
setxkbmap -layout "us, ru" -option "grp:ctrl_shift_toggle"
setxkbmap -option ctrl:nocaps       # Make Caps Lock a Control key
# This will make the Shift+NumLock shortcut toggle mouse keys
setxkbmap -option "keypad:pointerkeys"
# Turn on c-a-backspace
setxkbmap -option terminate:ctrl_alt_bksp
xmodmap .Xmodmap

# Set repeat rate
xset r rate 400 80

# Set desktop bg
feh  --bg-scale /home/randy/Pictures/wall.jpg &

# make terminus visible for xfontsel and clients
xset +fp /.fonts
xset +fp /usr/share/fonts/local

# Disable screen turn off
xset s off

# Rebuild xdg menu for awesome
xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu > ~/.config/awesome/archmenu.lua &

# Start xxkb
# xxkb &

# Pulsdaudio helper icon
# pasystray &

# Clipboard manager
# parcellite &
copyq &

# Hide mouse when not required
# unclutter -grab & # Win i3 works bad
# unclutter & With Awesome there is focus stealing bug

# Composition
compton -b

# Set wacom buttons correctly
xsetwacom --set "Wacom Intuos3 9x12 stylus" Button 2 "button +3"
xsetwacom --set "Wacom Intuos3 9x12 stylus" Button 3 "button +2"

# File manager
#thunar --daemon

# Lightons script
/home/randy/bin/lightsOn.sh &

# Start urxvt daemon (quiet, forked, only for this X session)
urxvtd -q -f -o

# Easystroke
# easystroke &

# Mounting provider
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Ssh agent
# eval `ssh-agent -s`

# Mpd
( ( sleep 2 && /usr/bin/mpd) & )

# exec openbox
exec awesome
# exec xmonad
# exec i3 -V >> /tmp/i3log 2>&1
# exec startfluxbox
# exec gnome-session
# exec startkde
# exec startxfce4

