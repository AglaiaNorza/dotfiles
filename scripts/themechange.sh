#!/bin/bash

input="$1"

if [ -z "$input" ]; then
    read -e -p "tokyonight(1), gruvbox(2), gruvbox material(3), rose-pine(4), nord(5): " input
fi

new=""
i3barc=""
obtheme=""

case $input in 
    "1")
        new="tokyonight"
        i3barc="#2b364d"
        i3txt="#d9dff9"
        obtheme="Tokyo Night"
        ;;
    "2")
        new="gruvbox"
        i3barc="#32302f"
        i3txt="#a89984"
        obtheme="Obsidian gruvbox"
        ;;
    "3")
        new="gruvboxmaterial"
        i3barc="#32302f"
        i3txt="#d4be98"
        obtheme="Material Gruvbox"
        ;;
    "4")
        new="rosepine"
        i3barc="#393552"
        i3txt="e0def4"
        obtheme="Rosé Pine"
        ;;
    "5")
        new="nord"
        i3barc="#3d4a54"
        i3txt="#d9dff9"
        obtheme="Obsidian Nord"
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
(most of the plugins required for these to work are listed in the respective files, but i might have forgotten some)

oldcolors=$(grep '^# ' "$colors" | awk '{print $2}').txt

mv $colors "$HOME/.config/i3/colors/$oldcolors"
mv $newcolors $colors

sed -i '1,/#endcolors/d' $i3config

cat $colors $i3config > temp.txt && mv temp.txt $i3config

sed -i -e "s/background=#.*/background=$i3barc/" \
    -e "s/border=#.*/border=$i3barc/" \
    -e "s/color=#.*/color=$i3txt/" \
    "$HOME/.config/i3blocks/config" 

mv "$HOME/Pictures/backgrounds/current.png" "$HOME/Pictures/backgrounds/$old.png"
mv "$HOME/Pictures/backgrounds/$new.png" "$HOME/Pictures/backgrounds/current.png"

if [[ "$XDG_SESSION_DESKTOP" == "i3" ]]; then
    #reload to see the bar
    i3 restart
fi

# ------- keyboard rgb -------

# uses https://github.com/dokutan/rgb_keyboard
sudo rgb_keyboard --custom-pattern "$HOME/.config/keyboard/$new.conf"

# ------- obsidian -------
sed -i -e "s/\"cssTheme\".*/\"cssTheme\": \"$obtheme\"/" "$HOME/Documents/uni/obsidian-vault/.obsidian/appearance.json"

