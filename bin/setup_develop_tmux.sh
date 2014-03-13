#!/bin/bash

#tmux new-session -d -s main

tmux new-window -t 0:2 'zsh -is eval "git st"'
tmux rename-window -t 0:2 Git

tmux new-window -t 0:3 'vim'
tmux rename-window -t 0:3 Vim

tmux new-window -t 0:4 'zsh -is eval "ls -l"'
tmux rename-window -t 0:4 Debug

tmux select-window -t 0:1
#tmux attach -t main


##!/bin/bash
#################################################################################
## tmuxgo - Dale Bewley <dale @ guifreelife org> - Sat Feb 19 08:53:30 PST 2011
##-------------------------------------------------------------------------------
## Use me to get your tmux session restored after a reboot or reattach daily.
## Just type tmuxgo every morning and hit ^bd at the end of the day. Login
## remotely and do the same.
##
## Attaches to an existing session named $SESSION or will create one if missing.
## The created session will be pre-populated with a number of windows. 
##
## For example, window 0 running IRC, window 1 running email, window 2 logged
## into a router used daily.
##
##
## Bugs & Todos:
##   o If session already exists, instantiate any missing windows.
##     This could be done by checking tmux list-windows, not sure needed.
##
##   o Window 0 automatically changes name to 'weechat 0.3.3', ignoring 
##     the -n option. The following should fix it, but does not:
##       tmux set-window-option -t $SESSION:0 automatic-rename off
##     Same thing happens when issuing configure command on Arista switches.
##     Note that name (#W) and title (#T) are not necessarily the same value.
#################################################################################
# 
## the name of your primary tmux session
#SESSION=$USER
## your IRC nickname
#IRC_NICK=$USER
# 
## if the session is already running, just attach to it.
#tmux has-session -t $SESSION
#if [ $? -eq 0 ]; then
#    echo "Session $SESSION already exists. Attaching."
#    sleep 1
#    tmux attach -t $SESSION
#    exit 0;
#fi
# 
## create a new session, named $SESSION, and detach from it
#tmux new-session -d -s $SESSION
# 
## Now populate the session with the windows you use every day
## Some windows I specifically want at a particular index.
## I always want IRC in window 0 and Email in window 1.
# 
## 0 - IRC
#tmux set-window-option -t $SESSION -g automatic-rename off
#tmux new-window    -t $SESSION:0 -k -n irc # weechat-curses
#tmux set-window-option -t $SESSION:0 automatic-rename off
##tmux set-window-option -t $SESSION:0 monitor-content $IRC_NICK
#tmux rename-window -t $SESSION:0 -n irc
## 1 - Mail
#tmux new-window    -t $SESSION:1 -n mail alpine
## 2 - Music (on one workstation, nothing on another)
## So that I can quickly hit ^b2<spacebar> to pause my tunes, I always put music in window 2.
## Makefile target does this: mpg123 --shuffle --control --list *m3u
##tmux new-window -t $SESSION:2 -n music 'cd ~/Music; make music'
#tmux new-window    -t $SESSION:2 -n temp # just to leave 2 empty
# 
## After those base windows are statically defined, what follows depends where
## I'm working and what my focus is.
## So these new windows will just  number sequentially.
#tmux new-window    -t $SESSION -a -n work
#tmux new-window    -t $SESSION -a -n root  'sudo su -'
#tmux new-window    -t $SESSION -a -n fw    'ssh root@fw'
#tmux new-window    -t $SESSION -a -n virt  'ssh root@sammy'
#tmux new-window    -t $SESSION -a -n lime  'ssh root@lime'
#tmux new-window    -t $SESSION -a -n scsi  'ssh root@donkey'
#tmux new-window    -t $SESSION -a -n back  'ssh root@bacula'
#tmux kill-window   -t $SESSION:2 # just want to leave slot 2 empty 
##
# 
## all done. select starting window and get to work
## you may need to cycle through windows and type in passwords
## if you don't use ssh keys
#tmux select-window -t $SESSION:0
#tmux attach -t $SESSION
