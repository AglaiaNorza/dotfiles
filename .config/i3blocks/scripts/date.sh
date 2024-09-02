#!/bin/bash

date +%d-%m

if [ "${BLOCK_BUTTON}" ]; then
    konsole -e sh -c "cal -3; read -p 'press enter to close...' "
fi
