#!/bin/sh
# Make a new session named local
#      a new window named $USER
#      running tmux in a socket named $USER
#      (todo: the session isn't named)

if tmux has-session 2>/dev/null; then # if session exists, attach to it
  tmux attach
else 
  # make the session (and the nested session)
  tmux new-session -d -s 'local' -n $USER tmux -L $USER
  # make a new window in the nested session named melon,
  # SSH'ing to my server and attaching to it's tmux session
  tmux new-window -n 'melon' ssh melon@S23LDE12 -t '. /etc/profile; . ~/.profile; tmux attach'
  # the fact I need to do this is indicative of code demons
  tmux source ~/.tmux.conf
  # Attach to the session you just made
  tmux attach
fi
