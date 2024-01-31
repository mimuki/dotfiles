#!/bin/bash

if tmux show-option -vg prefix | grep a; then # the outer session is focused
  if [[ "$1" == '1' ]] ; then
    tmux next-window
  else
    tmux previous-window
  fi
else # the inner session is focused
  if [[ "$1" == '1' ]] ; then
    tmux send-keys C-S-Right
  else
    tmux send-keys C-S-Left
  fi
fi

