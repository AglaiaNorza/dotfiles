#!/bin/bash

bluetoothctl show | grep -q "Powered: yes"

if [ $? -eq 0 ]; then
    connected_devices=$(bluetoothctl info | grep "Connected: yes" | wc -l)

    if [ $connected_devices -gt 0 ]; then
        echo " con"
    else
        echo " disc"
    fi
else
    echo " off"
fi

# on click
if [ "${BLOCK_BUTTON}"  ]; then
    blueman-manager
fi
