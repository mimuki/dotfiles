#!/bin/bash
ROOTPATH='/home/mimuki/.config/qutebrowser/'

cat $ROOTPATH/dynamic/discord.css $ROOTPATH/templates/theme.css $ROOTPATH/templates/discord/horizontal_server_list.css $ROOTPATH/templates/discord/float.css $ROOTPATH/templates/discord/server_list.css > $ROOTPATH/theme.css

