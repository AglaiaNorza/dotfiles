#!/bin/bash

# quickly moves files to the attachment directory of my obsidian vault (and renames them)
echo "DISPLAY=$DISPLAY" >> /tmp/obs_debug.log
echo "XAUTHORITY=$XAUTHORITY" >> /tmp/obs_debug.log
env | grep -i xclip >> /tmp/obs_debug.log

# Test clipboard
echo "hello" | xclip -selection clipboard
sleep 0.5
xclip -o >> /tmp/obs_debug.log 2>&1

input="$1"

YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ -z "$input" ] && [ -z "$2" ]; then
    echo -e "quickly move files to the attachment directory of my obsidian vault!\nusage: ${BLUE}$0 <new_file_name> ${YELLOW}[directory_name]"
    exit 1
fi

if [ "$input" = "--prompt" ]; then
    read -e -p "file name: " input
fi

if [ -z "$2"  ]; then
    location="$HOME/Pictures/Screenshots"
else
    if [ "$2" = "d" ]; then
        location="$HOME/Downloads"
    
    elif [ -d "$HOME/$2" ]; then
        location="$HOME/$2"
    
    else
        echo "not a directory"
        exit 1
    fi
fi

# latest file
file=$(ls "$location" -t | head -n1)

if [ -z "$file" ]; then
    echo "no files in there"
    exit 1
fi

extension="${file##*.}"

newloc="$HOME/Documents/uni/obsidian-vault/attachments/"

# handle duplicate names
declare -i i=0
while [ -e "$newloc$input.$extension" ]; do
    i=$((i + 1))
    input="$input$i"
done

cliptext="ciao"

echo "aaaaa" | xclip -selection clipboard -loops 1

if command -v xclip >/dev/null && [[ -n $DISPLAY ]]; then
    echo "![[${input}.${extension}|center]]" | /usr/bin/xclip -selection clipboard -i
else
    echo "Clipboard not available: xclip not installed or no DISPLAY."
fi

mv "$location/$file" \
    "$newloc$input.$extension"


echo "Moved $file to $HOME/Documents/uni/obsidian-vault/attachments/$input.$extension"
