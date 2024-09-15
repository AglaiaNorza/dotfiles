#!/bin/bash

track=$(playerctl metadata title)
artist=$(playerctl metadata artist)

if [ $? -ne 0 ]; then
    echo "silence"
else
    echo "$track - $artist"
fi
