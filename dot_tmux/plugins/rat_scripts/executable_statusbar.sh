#!/usr/bin/env bash
# Make sure the statusbar updates
# for the current directory
tmux refresh-client -S

# Show a different statusbar background
# based on program
#WINDOW=$(tmux list-windows | grep \* | awk '{print $2}')
#WINDOW=$(tmux lsw -F '#{window_name}#{window_active}'|sed -n 's|^\(.*\)1$|\1|p')
#if [[ $WINDOW = "xmpp" || $WINDOW = "csol" ]]
#then
#  tmux set-option status-bg "brightyellow"
#else
#  tmux set-option status-bg "#ffd477"
#fi
