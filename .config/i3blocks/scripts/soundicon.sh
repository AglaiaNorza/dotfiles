#!/bin/sh

# used to use amixer and awk, but i had issues with audio sources on my pc, so pamixer it is

ICON="  "
if [ "$(pamixer --get-mute)" = "true" ]
then
    ICON=" 󰸈 "
fi

echo "$ICON"

