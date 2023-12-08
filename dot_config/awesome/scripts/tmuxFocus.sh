#!/bin/bash
#
if [[ "$1" == '1' ]] ; then
  if [[ $(tmux list-windows | wc -l) != "1" ]]; then
    tmux next-window
  else
    tmux send-keys M-F10
  fi
else
  if [[ $(tmux list-windows | wc -l) != "1" ]]; then
    tmux previous-window
  else
    tmux send-keys M-F9
  fi
fi
