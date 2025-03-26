#!/bin/bash

basedir=~/Documents/tor

handle() {
    local input=$1

    if [ -f "$input" ]; then
        mnamer "$input" -b --movie-directory=/home/aglaia/Documents/tor/film --movie-api=omdb

    elif [ -d "$input" ]; then
        mnamer "$input" -b --movie-directory=/home/aglaia/Documents/tor/film --movie-api=omdb \ 
            --ignore '^(?!.*\.(avi|mkv|mp4|mov|flv|wmv|m4v|webm|3gp|mpeg|mpg|ts|vob)$).*$'

    fi
    
    title=$(ls -t $basedir/film | head -n 1 | sed 's/ ([0-9]\{4\})\.[a-zA-Z0-9]*$//')

    echo $title
}

for item in $basedir/downloads/*; do
    
    if [ -d "$item" ]; then

        if [ -d "$item/Featurettes" ]; then
            mv "$item/Featurettes" "$basedir/temp"
        fi
    
        title=$(handle "$item")

        mv $item/Featurettes/* "$basedir/featurettes/$title"

    elif [ -f "$item" ]; then
        handle "$item"
    fi
done
