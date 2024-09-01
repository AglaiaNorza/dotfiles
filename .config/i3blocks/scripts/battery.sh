#!/bin/bash

input=$(acpi)

# status (charging/discharging)
status=$(echo "$input" | awk -F": " '{print $2}' | awk -F", " '{print $1}')

# percentage
percentage=$(echo "$input" | awk -F", " '{print $2}' | awk -F"%" '{print $1}')

# time (left to charge or before death)
#time=$(echo "$input" | awk -F", " '{print $3}' | awk -F" until" '{print $1}')

# for PC
if (( $percentage == 0 )); then
    exit 1
fi

charging=" "
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

echo "$charge$charging$percentage%"
