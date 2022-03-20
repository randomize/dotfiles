#!/bin/bash

#xrandr --output DP1-8 --mode 1920x1080 --above eDP1
#xrandr --output DP1-1-8 --mode 1920x1080 --right-of DP1-8
#xrandr --output DP1-1-1 --mode 1920x1080 --rotate right --left-of DP1-8

#!/bin/sh
xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x1200 --rotate normal \
       --output DP1-1-1-8 --mode 1920x1200 --pos 4480x0 --rotate normal \
       --output DP1-1-8 --mode 2560x1440 --pos 1920x0 --rotate normal \
       --output DP1-8 --mode 1920x1200 --pos 0x0 --rotate normal \

# xrandr \
#     --output eDP1 --primary --mode 1920x1080 --pos 1200x1200 --rotate normal \
#     --output DP1-1-1-8 --mode 1920x1200 --pos 0x0 --rotate normal \
#     --output DP1-1-8 --mode 2560x1440 --pos 3120x0 --rotate normal \
#     --output DP1-8 --mode 1920x1200 --pos 1200x0 --rotate normal

# xrandr \
#     --output eDP1 --primary --mode 1920x1080 --pos 1200x1200 --rotate normal \
#     --output DP1-1-1 --mode 1920x1200 --pos 0x0 --rotate right \
#     --output DP1-1-8 --mode 2560x1440 --pos 3120x0 --rotate normal \
#     --output DP1-8 --mode 1920x1200 --pos 1200x0 --rotate normal


# xrandr \
#     --output eDP1 --primary --mode 1920x1080 --pos 1200x1200 --rotate normal \
#     --output DP1 --off --output DP1-1 --off \
#     --output DP1-1-1 --mode 1920x1200 --pos 0x0 --rotate right \
#     --output DP1-1-8 --mode 2560x1440 --pos 3120x0 --rotate normal \
#     --output DP1-8 --mode 1920x1200 --pos 1200x0 --rotate normal \
#     --output DP2 --off \
#     --output HDMI1 --off \
#     --output VIRTUAL1 --off \
#     --output HDMI-1-0 --off
