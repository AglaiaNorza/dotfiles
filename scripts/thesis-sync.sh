#!/bin/bash

OVERLEAF_DIR="$HOME/Documents/uni/tesi/overleaf"
PERSONAL_REPO="$HOME/Documents/uni/tesi/my-repo"
SRC_DIR="$PERSONAL_REPO/src"

# sync files to src/, respecting overleaf's .gitignore and deleting removed files
rsync -a --delete --exclude='*.pdf' --exclude='.git/' --exclude='.gitignore' "$OVERLEAF_DIR/" "$SRC_DIR/"

# extract the latest commit message from the overleaf repo
cd "$OVERLEAF_DIR" || exit
COMMIT_MSG=$(git log -1 --pretty=%B)

cd "$PERSONAL_REPO" || exit
git add src/

if [ -n "$(git status --porcelain src/)" ]; then
    git commit -m "$COMMIT_MSG"
    git push
    echo "synced + committed + pushed; message: '$COMMIT_MSG'"
else
    echo "no new changes"
fi

