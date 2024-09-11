#!/bin/sh

# had an old one with amixer and awk and stuff but i had issues with my audio sources on my pc so this uses pamixer instead
VOLUME_MUTE="🔇"
VOLUME_LOW="🔈"
VOLUME_MID="🔉"
VOLUME_HIGH="🔊"

SOUND_LEVEL=$(pamixer --get-volume)

ICON=$VOLUME_MUTE
if [ "$(pamixer --get-mute)" = "true" ]
then
    ICON="$VOLUME_MUTE"
else
    if [ "$SOUND_LEVEL" -lt 34 ]
    then
        ICON="$VOLUME_LOW"
    elif [ "$SOUND_LEVEL" -lt 67 ]
    then
        ICON="$VOLUME_MID"
    else
        ICON="$VOLUME_HIGH"
    fi
fi

echo $ICON$SOUND_LEVEL% | awk '{ printf("%s%s\n", $1, $2) }'

