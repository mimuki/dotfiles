#!/bin/bash
# explanation for future me:
# 	curl gets the entire "currently switched in" stuff which has a lot of irrelevant things.
# 	jq parses the json for the first fronters name
# 	sed removes the numbers
# 	awk pads the output
#  	sed removes the whole thing if it's null (no front)


# todo: find a good way to get name and other stuff, maybe? think banner -> wallpaper, etc
# curl https://api.pluralkit.me/v2/systems/mouse/fronters | jq -r .members[0].name | sed 's/[0-9]//g' | awk '{printf(" %s "), $1}' | sed 's/ null //' 
curl https://api.pluralkit.me/v2/systems/mouse/fronters | jq ".members[0] | {id: .id, name: .name, colour: .color, avatar: .avatar_url, wallpaper: .banner }"