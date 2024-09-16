#!/bin/bash

date +%d-%m

if [ "${BLOCK_BUTTON}" ]; then
    alacritty -e sh -c "cal -3; read -p 'press enter to close...' "
fi
