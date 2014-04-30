#!/bin/bash

#get current brightness
presbright=$(sudo ddccontrol dev:/dev/i2c-3 | grep -A1 0x10 | tr -d '\n\t' | sed 's/.*value=\([^a-zA-Z]*\),.*/\1/')
#stepsize for the brightness change
stepsize=10

case "$1" in
        up)
          newbright=$(( ${presbright}+${stepsize} ))
          newbright=$(echo $newbright | awk '{if($1 < 100){if($1 > 0) print $1; else print 0;} else print 100;}')

          # notify-send " " -i notification-display-brightness-low -h int:value:$newbright -h string:x-canonical-private-synchronous:brightness &
          sudo ddccontrol dev:/dev/i2c-3 -r 0x10 -w $newbright > /dev/null 2>&1
        ;;
        down)
          newbright=$(( ${presbright}-${stepsize} ))
          newbright=$(echo $newbright | awk '{if($1 < 100){if($1 > 0) print $1; else print 0;} else print 100;}')

          # notify-send " " -i notification-display-brightness-low -h int:value:$newbright -h string:x-canonical-private-synchronous:brightness &
          sudo ddccontrol dev:/dev/i2c-3 -r 0x10 -w $newbright > /dev/null 2>&1           
        ;;
        status)
          echo $presbright
        ;;
        *)
          echo "Accepted arguments are: up, down, status."
        ;;
esac

exit 0
