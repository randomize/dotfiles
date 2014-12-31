#!/bin/bash
#export TERM=xterm-256color
SESS_NAME='Rsh'
tmux attach -t $SESS_NAME || tmux new -s $SESS_NAME
