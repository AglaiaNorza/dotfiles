#!/bin/bash

# quickly moves files to the attachment directory of my obsidian vault (and renames them)

input="$1"

if [ -z "$input" ] && [ -z "$2" ]; then
    echo "usage: $0 <new_file_name> [directory_name]"
    exit 1
fi

if [ -z "$input" ]; then
    read -e -p \ 
        "insert the new name for the file (no extension): " input
fi

if [ -z "$2"  ]; then
    location="$HOME/Downloads"
else
    if [ -d "$HOME/$2" ]; then
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

mv "$location/$file" \
    "$HOME/Documents/uni/obsidian-vault/attachments/$input.$extension"

echo "Moved $file to $HOME/Documents/uni/obsidian-vault/attachments/$input.$extension"
