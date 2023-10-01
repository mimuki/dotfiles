#!/usr/bin/env bash
P=$(tmux show -wqv @quake)
if [ -n "$P" ] 
# The pane exists, so kill it
then
     tmux kill-pane -t$P
     tmux set -wu @quake
else
# The pane doesn't, so make it
     P=$(tmux split-window -l 35% -b -v -f -PF'#{pane_id}')
     tmux set -w @quake "$P"
     tmux select-pane -t$P
fi
