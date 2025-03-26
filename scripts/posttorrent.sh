#!/bin/bash

basedir=/media/mstor

handle() {
    local input=$1

    if [ -f "$input" ]; then
        /home/osmc/.local/bin/mnamer "$input" -b --movie-directory=/media/mstor/film/ --movie-api=omdb 2>/dev/null

    elif [ -d "$input" ]; then

        local film # the heaviest video file must be the movie
        film=(find "$input" -type f -iregex ".*\.\(avi\|mkv\|mp4\|mov\|flv\|wmv\|m4v\|webm\|3gp\|mpeg\|mpg\|ts\|vob\)$" -printf "%s %p\n" | sort -nr | head -n 1 | cut -d ' ' -f2-)
        
        if [ -n "$film" ]; then
            /home/osmc/.local/bin/mnamer "$film" -b --movie-directory=/media/mstor/film/ --movie-api=omdb 2>/dev/null
        fi

    fi
}

for item in $basedir/downloads/*; do
    crit=false
    temp="$basedir/temp"

    if [ -d "$item" ]; then

        for subdir in "$item"/*/; do
            if [[ -d "$subdir" && ! "$subdir" =~ ub ]]; then # for extras (not subs though)
                crit=true
                mv "$subdir"* "$temp/"
            fi
        done

        handle "$item"

        if [ "$crit" = true ]; then
            title=$(ls -t $basedir/film | head -n 1 | sed 's/ ([0-9]\{4\})\.[a-zA-Z0-9]*$//')

            mkdir -p "$basedir/featurettes/$title"
            mv "$temp/"* "$basedir/featurettes/$title/"
        fi

    elif [ -f "$item" ]; then
        handle "$item"
    fi

done
