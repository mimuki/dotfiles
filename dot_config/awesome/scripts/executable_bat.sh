#!/bin/bash
BAT0=`cat /sys/class/power_supply/BAT0/capacity`
BAT1=`cat /sys/class/power_supply/BAT1/capacity`
echo $(($BAT0+$BAT1))
#echo 100