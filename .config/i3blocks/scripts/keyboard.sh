#!/bin/bash

# kind of a workaround 
# (i should probably look for the string following "layout" but since i know the layout is going to be in the last two characters (+\n), i can do this instead)

echo $(setxkbmap -query | tail -c 3)

if (( $BLOCK_BUTTON == 1 )); then
    xinput enable 12
    notify-send -u normal "keyboard enabled"
elif (( $BLOCK_BUTTON == 3 )); then
    xinput disable 12
    notify-send -u critical "keyboard disabled"
fi
