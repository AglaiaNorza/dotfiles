#!/bin/bash

handle_length() {
    local text=$1
    
    if [ ${#text} -gt 12 ]; then
        echo "${text:0:12}.."
    else
        echo "$text"
    fi
}

if [[ "$HOSTNAME" == "archglaia" ]]; then

    track=$(playerctl metadata title)
    artist=$(playerctl metadata artist)
    
    if [ $? -ne 0 ]; then
       echo "silence"
    else
        echo "$(handle_length "$track") - $(handle_length "$artist")"
    fi

    if [ "${BLOCK_BUTTON}" ]; then
        exec spotify
    fi
fi
