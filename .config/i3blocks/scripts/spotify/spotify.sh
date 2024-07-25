#!/bin/bash

# source: me (i do not know shell scripting i derived this from observations)

# did not work without specific path for some reason !
status=$(~/.local/bin/spotifycli --statusshort)

if [ -n "$status" ]; then
    echo " $status"
else
    echo " silence"
fi
