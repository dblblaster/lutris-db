#!/bin/bash

# https://github.com/lutris/lutris/blob/9961fc3c1a921cf1c48f4fcedc66fc25e3f28fd0/lutris/settings.py#L45

game_slug=$(echo "$1" | grep -Po '(?<=lutris\:).*(?=\?)')
revision=$(echo "$1" | grep -Po '(?<=\?revision=).*$')
echo "https://lutris.net/api/installers/games/$game_slug/revisions/$revision"
