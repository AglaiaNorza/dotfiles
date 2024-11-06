#!bin/bash

cd ~/Documents/uni/obsidian-vault && git pull && \
    if [[ -n $(git status --porcelain )]]; then
        git add . && \
            git commit -m "vault backup: $(date)" && git push

    fi

cd ~/Documents/uni/quartz && git submodule update --remote content/vault && npx quartz sync
