#!/bin/bash
ROOTPATH='/home/mimuki/.config/qutebrowser/'

cat $ROOTPATH/dynamic/discord.css $ROOTPATH/templates/theme.css $ROOTPATH/templates/discord/new_list.css $ROOTPATH/templates/discord/float.css > $ROOTPATH/theme.css

