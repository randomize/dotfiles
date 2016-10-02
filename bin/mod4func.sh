#!/usr/bin/env bash


if [ $# -lt 1 ]
then
        echo "Usage : $0 F-keyNumber"
        exit
fi

case "$1" in

1)  echo "F1 is pressed"
    notify-send "Next keygene"
    tmux send-keys -t xmp n  
    ;;
2)  echo "F2 is pressed"
    notify-send "Prew keygene"
    tmux send-keys -t xmp p
    ;;
3)  echo "F3 is pressed"
    notify-send "`tmux capture-pane -t xmp -p | grep -B 1 'Module name' | tail -2 `"
    ;;
4)  echo "F4 is pressed"
    notify-send "Lovely keygen stored"
    tmux capture-pane -t xmp -p | grep -B 1 'Module name' | tail -2 >> ~/Documents/nice-xms.txt
    ;;
5)  echo "F5 is pressed"
    ;;
6)  echo "F6 is pressed"
    ;;
7)  echo "F7 is pressed"
    ;;
8)  echo "F8 is pressed"
    ;;
9)  echo "F9 is pressed"
    ;;
10) echo "F10 is pressed"
    ;;
11) echo "F11 is pressed"
    ;;
12) echo "F12 is pressed"
    ;;
*)  echo "WTF happened?"
    ;;
esac
