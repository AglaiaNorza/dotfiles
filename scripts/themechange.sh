#!/bin/bash

input="$1"

YELLOW='\033[0;33m'
NC='\033[0m'

if [ -z "$input" ]; then
    echo -e "${YELLOW}change the system theme by moving some files around !\nchoose a theme by selecting a number${NC}"
    read -e -p "tokyonight(1), gruvbox(2), gruvbox material(3), rose-pine(4), nord(5), gruvbox-light(6): " input
fi

new=""
i3barc=""
obtheme=""
spotheme=""

case $input in 
    "1")
        new="tokyonight"
        i3barc="#2b364d"
        i3txt="#d9dff9"
        obtheme="Tokyo Night"
        spotheme="catpuccin-macchiato"
        ;;
    "2")
        new="gruvbox"
        i3barc="#32302f"
        i3txt="#a89984"
        obtheme="Obsidian gruvbox"
        spotheme="gruvbox-material-dark"
        ;;
    "3")
        new="gruvboxmaterial"
        i3barc="#32302f"
        i3txt="#d4be98"
        obtheme="Material Gruvbox"
        spotheme="gruvbox-material-dark"
        ;;
    "4")
        new="rosepine"
        i3barc="#393552"
        i3txt="#e0def4"
        obtheme="Rosé Pine"
        spotheme="rosepine"
        ;;
    "5")
        new="nord"
        i3barc="#3d4a54"
        i3txt="#d9dff9"
        obtheme="Obsidian Nord"
        spotheme="nord-dark"
        ;;
    "6")
        new="gruvboxlight"
        i3barc="#665c54"
        i3txt="#ebdbb2"
        obtheme="Obsidian gruvbox"       
        spotheme="gruvbox-material-dark"
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
    -e "s/color=#.*/color=$i3txt/" \
    "$HOME/.config/i3blocks/config" 

mv "$HOME/.config/backgrounds/current.png" "$HOME/.config/backgrounds/$old.png"
mv "$HOME/.config/backgrounds/$new.png" "$HOME/.config/backgrounds/current.png"

if [[ "$XDG_SESSION_DESKTOP" == "i3" ]]; then
    #reload to see the bar
    i3 restart
fi

# ------- yazi -------
old=$(head -n 1 ~/.config/yazi/theme.toml | sed 's/[#\n]//g')

mv ~/.config/yazi/theme.toml ~/.config/yazi/alt/$old.toml
mv ~/.config/yazi/alt/$new.toml ~/.config/yazi/theme.toml

# ------- obsidian -------
sed -i -e "s/\"cssTheme\".*/\"cssTheme\": \"$obtheme\"/" "$HOME/Documents/uni/obsidian-vault/.obsidian/appearance.json"

# dark vs light themes
if [[ "$new" == "gruvboxlight" ]]; then
    sed -i -e 's/\("theme": *\).*/\1"moonstone",/' "$HOME/Documents/uni/obsidian-vault/.obsidian/appearance.json"
elif [[ "$old" == "gruvboxlight" ]]; then
    sed -i -e 's/\("theme": *\).*/\1"obsidian",/' "$HOME/Documents/uni/obsidian-vault/.obsidian/appearance.json"
fi

if [[ "$HOSTNAME" == "archglaia" ]]; then

    # ------- keyboard rgb -------
    # uses https://github.com/dokutan/rgb_keyboard
    sudo rgb_keyboard --custom-pattern "$HOME/.config/keyboard/$new.conf"

    # ------- spicetify (Dribbblish) ------- 
    spicetify config color_scheme "$spotheme"
    spicetify apply

fi

