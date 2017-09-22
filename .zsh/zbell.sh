#!/usr/bin/env zsh

# This script prints a bell character when a command finishes
# if it has been running for longer than $zbell_duration seconds.
# If there are programs that you know run long that you don't
# want to bell after, then add them to $zbell_ignore.
#
# This script uses only zsh builtins so its fast, there's no needless
# forking, and its only dependency is zsh and its standard modules
#
# Written by Jean-Philippe Ouellet <jpo@vt.edu>
# Made available under the ISC license.

# only do this if we're in an interactive shell
[[ -o interactive ]] || return

# get $EPOCHSECONDS. builtins are faster than date(1)
zmodload zsh/datetime || return

# make sure we can register hooks
autoload -Uz add-zsh-hook || return

# initialize zbell_duration if not set
(( ${+zbell_duration} )) || zbell_duration=15

# initialize zbell_ignore if not set
(( ${+zbell_ignore} )) || zbell_ignore=(vim less more watch htop top ssh vi man ping traceroute vlc mplayer mpv tail tmux screen)

# initialize it because otherwise we compare a date and an empty string
# the first time we see the prompt. it's fine to have lastcmd empty on the
# initial run because it evaluates to an empty string, and splitting an
# empty string just results in an empty array.
zbell_timestamp=$EPOCHSECONDS
zbell_ticks=0
start_time=`date "+%X"`

# right before we begin to execute something, store the time it started at
zbell_begin() {
	zbell_timestamp=$EPOCHSECONDS
	zbell_lastcmd=$2
   zbell_ticks=1
   start_time=`date "+%X"`
}

# when it finishes, if it's been running longer than $zbell_duration,
# and we dont have an ignored command in the line, then print a bell.
zbell_end() {
   zbell_exit_status=$?
	ran_long=$(( $EPOCHSECONDS - $zbell_timestamp >= $zbell_duration ))

   local -a drop_words
   drop_words=(builtin command nocorrect noglob nohup LANG=C)

	has_ignored_cmd=0
	for cmd in ${(s:;:)zbell_lastcmd//|/;}; do
        for key in ${drop_words}; do
            cmd=${cmd/${key}/}
        done
		words=(${(z)cmd})
		util=${words[1]}
		if (( ${zbell_ignore[(i)$util]} <= ${#zbell_ignore} )); then
			has_ignored_cmd=1
			break
		fi
	done

   if (( ! $has_ignored_cmd )) && (( ran_long )) && (( $zbell_ticks )); then
      zbell_cmd_duration=$(( $EPOCHSECONDS - $zbell_timestamp ))
      if [[ `uname` == 'Darwin' ]] then 
          terminal-notifier -sender SystemEvents -sound default -message "Job completed on $HOST: $zbell_lastcmd = $zbell_exit_status \n Started at : ${start_time}\n Compleated in : $zbell_cmd_duration seconds"
      else
          notify-send --icon=gtk-info Finished "Job completed on $HOST: $zbell_lastcmd = $zbell_exit_status \n Started at : ${start_time}\n Compleated in : $zbell_cmd_duration seconds"
      fi
	fi

   zbell_ticks=0

}

# register the functions as hooks
add-zsh-hook preexec zbell_begin
add-zsh-hook precmd zbell_end
