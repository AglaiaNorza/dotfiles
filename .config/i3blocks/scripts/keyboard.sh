#!/bin/bash

# kind of a workaround 
# (i should probably look for the string following "layout" but since i know the layout is going to be in the last two characters (+\n), i can do this instead)

echo $(setxkbmap -query | tail -c 3)
