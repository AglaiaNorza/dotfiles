#!/bin/bash
input="$1"

if [ -z "$input" ]; then
    read -e -p "tokyonight(1), gruvbox(2), gruvbox material(3), rose-pine(4), nord(5): " input
fi

new=""

case $input in
    "1")
        new="tokyonight"
        ;;
    "2")
        new="gruvbox"
        ;;
    "3")
        new="gruvboxmaterial"
        ;;
    "4")
        new="rosepine"
        ;;
    "5")
        new="nord"
        ;;
esac

adir="$HOME/.config/alacritty"
newcolors="$adir/$new.txt"
alacritty="$adir/alacritty.toml"

old=$(grep '^#' "$alacritty" | awk '{print $2}').txt

sed -n '/#/, $p' "$alacritty" > "$adir/$old"
sed -i '/#/, $d' "$alacritty" 
cat "$newcolors" >> "$alacritty"
