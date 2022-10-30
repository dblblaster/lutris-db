#!/bin/bash

slug=$(echo "$1" | grep -Po '(?<=lutris\:)[-.\w]+')


# https://github.com/lutris/lutris/blob/9961fc3c1a921cf1c48f4fcedc66fc25e3f28fd0/lutris/settings.py#L43
url="https://lutris.net/api/installers/$slug"
apiresponse=$(curl "$url")

game_slug=$(echo "$apiresponse" | jq '.results | .[] | .game_slug' | sed -e 's/\"//g')
mkdir -p "games/$game_slug"
echo "$apiresponse" | jq '.results | .[]' > "games/$game_slug/$slug".json
printf "### url\n\n$url\n\n" > "games/$game_slug/$slug".md
printf "### game_slug\n\n$game_slug\n\n" >> "games/$game_slug/$slug".md
printf "### runner\n\n$(echo "$apiresponse" | jq '.results | .[] | .runner' | sed -e 's/^\"//g' -e 's/\"$//g' -e 's/%/%%/g')\n\n" >> "games/$game_slug/$slug".md
printf "### version\n\n$(echo "$apiresponse" | jq '.results | .[] | .version' | sed -e 's/^\"//g' -e 's/\"$//g' -e 's/%/%%/g')\n\n" >> "games/$game_slug/$slug".md
printf "### description\n\n$(echo "$apiresponse" | jq '.results | .[] | .description' | sed -e 's/^\"//g' -e 's/\"$//g' -e 's/%/%%/g')\n\n" >> "games/$game_slug/$slug".md
printf "### notes\n\n\`\`\`\n$(echo "$apiresponse" | jq '.results | .[] | .notes' | sed -e 's/^\"//g' -e 's/\"$//g' -e 's/%/%%/g')\n\`\`\`\n\n" >> "games/$game_slug/$slug".md
printf "### credits\n\n\`\`\`\n$(echo "$apiresponse" | jq '.results | .[] | .credits' | sed -e 's/^\"//g' -e 's/\"$//g' -e 's/%/%%/g')\n\`\`\`\n\n" >> "games/$game_slug/$slug".md
printf "### reason\n\n\`\`\`\n$(echo "$apiresponse" | jq '.results | .[] | .reason' | sed -e 's/^\"//g' -e 's/\"$//g' -e 's/%/%%/g')\n\`\`\`\n\n" >> "games/$game_slug/$slug".md
printf "### content\n\n\`\`\`\n$(echo "$apiresponse" | jq '.results | .[] | .content' | sed -e 's/^\"//g' -e 's/\"$//g' -e 's/%/%%/g')\n\`\`\`\n\n" >> "games/$game_slug/$slug".md
