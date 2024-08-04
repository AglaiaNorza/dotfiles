#!/bin/bash

input=$(acpi)

# percentage
percentage=$(echo "$input" | awk -F", " '{print $2}' | awk -F"%" '{print $1}')

echo "$percentage%"
