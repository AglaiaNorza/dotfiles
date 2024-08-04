#!/bin/bash

input=$(acpi)

status=$(echo "$input" | awk -F": " '{print $2}' | awk -F", " '{print $1}')

# percentage
percentage=$(echo "$input" | awk -F", " '{print $2}' | awk -F"%" '{print $1}')

charging=""
charge="󱊡"

if [[ "$status" == "Charging" ]]; then
    charging="󱐋"
fi

if (( $percentage == 100 )); then
    charge="󰂄"

elif (( $percentage > 70 )); then
    charge="󱊣"

elif (( $percentage > 49 )); then
    charge="󱊢"
fi

echo " $charge$charging "
