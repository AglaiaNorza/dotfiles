#!/bin/bash

# uuuh don't think i'll ever actually need this but maybe sometimes
# i might not want to have a huge "gay sex" ascii drawing on my terminal

if [[ "$1" == "unsafe" ]] && grep -q -- "--safe" ~/.zshrc; then
       sed -i 's/ --safe//' ~/.zshrc
elif ! grep -q -- "--safe" ~/.zshrc; then
        sed -i '/python ~\/scripts\/printquote.py/s/$/ --safe/' ~/.zshrc
fi
