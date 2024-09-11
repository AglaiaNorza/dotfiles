#!/bin/bash

input="$1"

if [ -z "$input" ]; then
    read -e -p "tokyonight(1), gruvbox(2), gruvbox material(3), rose-pine(4), nord(5): " input
fi

new=""
i3barc=""

case $input in 
    "1")
        new="tokyonight"
        i3barc="#2b364d"
        ;;
    "2")
        new="gruvbox"
        i3barc="#32302f"
        ;;
    "3")
        new="gruvboxmaterial"
        i3barc="#32302f"
        ;;
    "4")
        new="rosepine"
        i3barc="#393552"
        ;;
    "5")
        new="nord"
        i3barc="#3d4a54"
        ;;
esac

if [ -n "$new" ]; then
    echo "selected $new"

    old=$(head -n 1 ~/.config/nvim/lua/plugins/colorscheme.lua | sed 's/[-\n]//g')
    
    if [ "$old" = "$new" ]; then
        echo "that's the current colorscheme, you idiot"
        exit 1
    fi
# -------- nvim ---------   
    mv ~/.config/nvim/lua/plugins/colorscheme.lua ~/.config/nvim/alt/$old.lua
    mv ~/.config/nvim/alt/$new.lua ~/.config/nvim/lua/plugins/colorscheme.lua

fi

# -------- alacritty --------
adir="$HOME/.config/alacritty"

newcolors="$adir/$new.txt"
alacritty="$adir/alacritty.toml"

oldcolors=$(grep '^#' "$alacritty" | awk '{print $2}').txt

sed -n '/#/, $p' "$alacritty" > "$adir/$oldcolors"
sed -i '/#/, $d' "$alacritty"
cat "$newcolors" >> "$alacritty"

# ------- i3 -------
newcolors="$HOME/.config/i3/colors/$new.txt"
colors="$HOME/.config/i3/colors/colors.txt"

i3config="$HOME/.config/i3/config"

cp $i3config "$i3config.bak"

oldcolors=$(grep '^# ' "$colors" | awk '{print $2}').txt

mv $colors "$HOME/.config/i3/colors/$oldcolors"
mv $newcolors $colors

sed -i '1,/#endcolors/d' $i3config

cat $colors $i3config > temp.txt && mv temp.txt $i3config

sed -i -e "s/background=#.*/background=$i3barc/" \
    -e "s/border=#.*/border=$i3barc/" \
    "$HOME/.config/i3blocks/config" 

mv "$HOME/Pictures/backgrounds/current.png" "$HOME/Pictures/backgrounds/$old.png"
mv "$HOME/Pictures/backgrounds/$new.png" "$HOME/Pictures/backgrounds/current.png"

if [[ "$XDG_SESSION_DESKTOP" == "i3" ]]; then
    #reload to see the bar
    i3 restart
fi
