#!/bin/bash
# jan Tepo li wawa a
# this works by witchcraft, and should display only the currently used battery's wattage.
awk '$1!=0{printf("%.1f W", $1*10^-6)}' /sys/class/power_supply/BAT{1,0}/power_now | head -1
