#!/bin/sh
# TODO: i don't think this is the right way of checking if a dir exists
if [ ! -d "~/Projects/halley" ]
then
  git clone https://github.com/mimuki/halley.git ~/Projects/halley
fi


