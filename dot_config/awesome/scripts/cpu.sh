#!/bin/bash
# stolen from https://stackoverflow.com/questions/9229333/how-to-get-overall-cpu-usage-e-g-57-on-linux
# i have no clue how it works or if it's even accurate lol
ps -A -o pcpu | tail -n+2 | paste -sd+ | bc | awk '{printf( "%.0f% "), $1}'