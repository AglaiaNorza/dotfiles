!/bin/sh

# source :
# https://github.com/miklhh/i3blocks-config/blob/master/.config/i3blocks/cpu/cpu_info.sh (uses lm_sensors/sysstat)

##CPU_USAGE=$(mpstat 1 1 | awk '/Average:/ {printf("%s\n", $(NF-9))}')
#echo "$TEMP" | awk '{ printf("%.0f°C\n"), $1}'

# differentiate between my pc and my laptop
if [[ "$HOSTNAME" == "desktop-di-aglaia" ]]; then 
    TEMP=$(sensors | grep 'Tctl' | grep ':[ ]*+[0-9]*.[0-9]*°C' -o | grep '+[0-9]*.[0-9]*°C' -o)

else 
    TEMP=$(sensors | grep 'Package id 0:\|Tdie' | grep ':[ ]*+[0-9]*.[0-9]*°C' -o | grep '+[0-9]*.[0-9]*°C' -o)
fi

# Format and print the temperature
echo "$TEMP" | awk '{ printf("%.0f°C\n", $1) }'
