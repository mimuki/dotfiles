#!/bin/sh
# TODO: i don't think this is the right way of checking if a dir exists
if [ ! -d "~/Projects/halley" ]
then
  git clone https://github.com/mimuki/halley ~/Projects/halley
fi

# Talon

if [ ! -d "~/.talon/user/community" ]
then
  git clone https://github.com/talonhub/community ~/.talon/user/community
fi

if [ ! -d "~/.talon/user/rango" ]
then
  git clone https://github.com/david-tejada/rango-talon ~/.talon/user/rango-talon
fi
if [ ! -d "~/.talon/user/cursorless" ]
then
  git clone https://github.com/cursorless-dev/cursorless-talon ~/.talon/user/cursorless-talon
fi
if [ ! -d "~/.talon/user/personal" ]
then
  git clone https://github.com/mimuki/talon ~/.talon/user/personal
fi
