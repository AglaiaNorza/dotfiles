#!/bin/bash

input=$(acpi)

# percentage
percentage=$(echo "$input" | awk -F", " '{print $2}' | awk -F"%" '{print $1}')

# for PC
if (( $percentage == 0 )); then
    exit 1
fi

echo "$percentage%"
