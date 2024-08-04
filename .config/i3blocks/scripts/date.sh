#!/bin/bash

echo $date '+%H:%M'

if [ "${BLOCK_BUTTON}" ]; then
    konsole -e cal
fi
