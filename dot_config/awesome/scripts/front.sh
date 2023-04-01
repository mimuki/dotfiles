#!/bin/bash
# explanation for future me:
# curl gets the entire "currently switched in" stuff which has a lot of irrelevant things.
# jq parses the json for the first fronters name
# sed removes the numbers

curl https://api.pluralkit.me/v2/systems/mouse/fronters | jq -r .members[0].name | sed 's/[0-9]//g' | awk '{printf(" %s "), $1}'