#!/bin/bash

# did not work without specific path for some reason !
status=$(~/.local/bin/spotifycli --statusshort)

if [ -n "$status" ]; then
    echo "$status"
else
    echo "silence"
fi

if [ "${BLOCK_BUTTON}" ]; then
    flatpak run com.spotify.Client
fi
