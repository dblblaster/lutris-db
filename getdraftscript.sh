#!/bin/bash

# https://github.com/lutris/lutris/blob/9961fc3c1a921cf1c48f4fcedc66fc25e3f28fd0/lutris/settings.py#L45

game_slug=$(echo "$1" | grep -Po '(?<=lutris\:).*(?=\?)')
revision=$(echo "$1" | grep -Po '(?<=\?revision=).*$')
echo $game_slug
echo $revision
url="https://lutris.net/api/installers/games/$game_slug/revisions/$revision"
apiresponse=$(curl "$url")
slug=$(echo "$apiresponse" | jq '.slug' | sed -e 's/\"//g')
mkdir -p "games/$game_slug"
echo "$apiresponse" | jq > "games/$game_slug/$slug".json
printf "### url\n\n$url\n\n" > "games/$game_slug/$slug".md
printf "### game_slug\n\n$(echo "$apiresponse" | jq '.game_slug' | sed -e 's/^\"//g' -e 's/\"$//g')\n\n" >> "games/$game_slug/$slug".md
printf "### runner\n\n$(echo "$apiresponse" | jq '.runner' | sed -e 's/^\"//g' -e 's/\"$//g')\n\n" >> "games/$game_slug/$slug".md
printf "### version\n\n$(echo "$apiresponse" | jq '.version' | sed -e 's/^\"//g' -e 's/\"$//g')\n\n" >> "games/$game_slug/$slug".md
printf "### description\n\n$(echo "$apiresponse" | jq '.description' | sed -e 's/^\"//g' -e 's/\"$//g')\n\n" >> "games/$game_slug/$slug".md
printf "### notes\n\n\`\`\`\n$(echo "$apiresponse" | jq '.notes' | sed -e 's/^\"//g' -e 's/\"$//g')\n\`\`\`\n\n" >> "games/$game_slug/$slug".md
printf "### content\n\n\`\`\`\n$(echo "$apiresponse" | jq '.content' | sed -e 's/^\"//g' -e 's/\"$//g')\n\`\`\`\n\n" >> "games/$game_slug/$slug".md
