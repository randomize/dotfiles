#!/bin/bash

# Simple script creates new urxvtc window with name as $1

classname=randy_scratchpad_$1

wid=$( xdotool search --classname ${classname} )

width=150
height=40
posx=370
posy=440

case "$1" in
   ranger)
      posx=136
      posy=300
      width=200
      height=50
      param="-depth 0"
      ;;

   ncmpcpp)
      posx=140
      posy=160
      width=210
      height=55
      ;;
esac

if [ -z "$wid" ]; then
    #your prefered urxvt output here.
    #urxvt -pe default,matcher -name scratchpad_urxvt_top -geometry 180x28
    urxvtc ${param} -name "${classname}" -geometry "${width}x${height}" -e $@
    #xdotool search --classname ${classname} windowsize 1800 500

    i3-msg "[instance=\"${classname}\"] floating enable; move position ${posx}px ${posy}px; border pixel 1; move scratchpad"

    # i3-msg "[instance=\"${classname}\"] move scratchpad"
    #for_window [instance="metask"] floating enable;
    #for_window [instance="metask"] move scratchpad; [instance="metask"] scratchpad show; move position 0px 22px; resize shrink height 300px; resize grow width 683px; move scratchpad

# else
   # Bring to front somwhow wtith i3-msg
   # echo "Running"
fi

i3-msg "[instance=\"${classname}\"] scratchpad show"
