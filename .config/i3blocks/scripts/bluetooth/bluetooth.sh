#!/bin/bash

# by me-ish

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

if [ "${BLOCK_BUTTON}"  ]; then
    blueman-manager
fi
