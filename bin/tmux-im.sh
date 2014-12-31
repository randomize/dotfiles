#!/bin/sh 
# Tmux IM 
tmux new-session -s 'IM' -n 'Mutt' -d 'mutt'
tmux new-window -n 'Toxic' 'toxic'
tmux new-window -n 'XMPP' 'profanity'
tmux new-window -n 'IRC' 'irssi'
tmux new-window -n 'Torrents' 'rtorrent'
tmux new-window -n 'ALSA' 'alsamixer'
tmux new-window -n 'Zsh' 'archey && dfc'
# tmux split-window -v 'ipython'
# tmux split-window -h
tmux -2 attach-session -d 
