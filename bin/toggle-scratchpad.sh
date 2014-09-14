#!/bin/bash

# Simple script creates new urxvtc window with name as $1

classname=randy_scratchpad_$1

wid=$( xdotool search --classname ${classname} )

if [ -z "$wid" ]; then
    #your prefered urxvt output here.
    #urxvt -pe default,matcher -name scratchpad_urxvt_top -geometry 180x28
    urxvtc -name "${classname}" -geometry 272x50 -e $@
    #xdotool search --classname ${classname} windowsize 1800 500

    i3-msg "[instance=\"${classname}\"] floating enable; move position 0px 0px; move scratchpad"

    # i3-msg "[instance=\"${classname}\"] move scratchpad"
    #for_window [instance="metask"] floating enable;
    #for_window [instance="metask"] move scratchpad; [instance="metask"] scratchpad show; move position 0px 22px; resize shrink height 300px; resize grow width 683px; move scratchpad

# else
   # Bring to front somwhow wtith i3-msg
   # echo "Running"
fi

i3-msg "[instance=\"${classname}\"] scratchpad show"
