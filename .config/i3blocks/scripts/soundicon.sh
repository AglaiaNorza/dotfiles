#!/bin/sh

# source: a part of https://github.com/miklhh/i3blocks-config/blob/master/.config/i3blocks/sound/sound_info.sh

MUTED=$(amixer get Master | awk ' /%/{print ($NF=="[off]" ? 1 : 0); exit;}')

ICON="  "
if [ "$MUTED" = "1" ]
then
    ICON=" 󰸈 "
fi

echo "$ICON"

