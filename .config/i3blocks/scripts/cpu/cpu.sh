#!/bin/sh

# source :
# https://github.com/miklhh/i3blocks-config/blob/master/.config/i3blocks/cpu/cpu_info.sh (uses lm_sensors/sysstat)

TEMP=$(sensors | grep 'Package id 0:\|Tdie' | grep ':[ ]*+[0-9]*.[0-9]*°C' -o | grep '+[0-9]*.[0-9]*°C' -o)
#CPU_USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%s\n", $(NF-9))}')
echo "$TEMP" | awk '{ printf("cpu:%2s\n"), $1}'

