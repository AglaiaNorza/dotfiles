#!/bin/bash

input="$1"

if [ -z "$input" ]; then
        # which bar do i want to change to
    read -e -p "monobar(1), iconbar(2), underlinedbar(3): " input
fi

new=""

case $input in

    "1")
        new="configmono"
        ;;
    "2")
        new="configicons"
        ;;
    "3")
        new="configunderlined"
        ;;

esac

# if it's a valid bar
if [ -n "$new" ]; then
    echo "selected $new"
    # takes the first line of the current config (its "title") 
    title=$(echo "$(head -n 1 ~/.config/i3blocks/config)" | sed 's/[#\n]//g')
    # switches the two configs
    mv ~/.config/i3blocks/config ~/.config/i3blocks/$title
    mv ~/.config/i3blocks/$new ~/.config/i3blocks/config
fi

