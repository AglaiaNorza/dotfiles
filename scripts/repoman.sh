#!/bin/bash
CONFIG_FILE="$HOME/.config/repoman.conf"

if [[ -f "$CONFIG_FILE" ]]; then
    declare -A REPOS
    source "$CONFIG_FILE"
else
    echo -e "\033[0;31mError: config file not found at $CONFIG_FILE\033[0m"
    exit 1
fi

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # (no color)

check_status() {
    echo -e "${YELLOW}checking repository statuses... (fetching remotes)${NC}\n"
    
    for key in "${!REPOS[@]}"; do
        path="${REPOS[$key]}"
        
        # check if the directory and git repo exist
        if [ ! -d "$path/.git" ]; then
            echo -e "${RED}► [$key] error: Not a valid git repository at $path${NC}"
            continue
        fi

        cd "$path" || continue
        
        git fetch -q 2>/dev/null
        
        # check for uncommitted local files
        UNCOMMITTED=$(git status --porcelain)
        
        # get current branch and remote branch
        BRANCH=$(git rev-parse --abbrev-ref HEAD)
        REMOTE=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
        
        if [ -z "$REMOTE" ]; then
            echo -e "► [$key] ${YELLOW}no remote tracking branch configured.${NC}"
            continue
        fi

        # calculate ahead/behind commit counts
        AHEAD=$(git rev-list --left-right --count $BRANCH...$REMOTE | awk '{print $1}')
        BEHIND=$(git rev-list --left-right --count $BRANCH...$REMOTE | awk '{print $2}')

        if [ -n "$UNCOMMITTED" ] || [ "$AHEAD" -gt 0 ] || [ "$BEHIND" -gt 0 ]; then
            echo -e "${YELLOW}► [$key]${NC} ($path)"
            if [ -n "$UNCOMMITTED" ]; then
                echo -e "  ${RED}↳ has uncommitted local changes${NC}"
            fi
            if [ "$AHEAD" -gt 0 ]; then
                echo -e "  ${GREEN}↳ ahead of remote by $AHEAD commit(s)${NC}"
            fi
            if [ "$BEHIND" -gt 0 ]; then
                echo -e "  ${RED}↳ behind remote by $BEHIND commit(s)${NC}"
            fi
            echo ""
        fi
    done
    echo -e "${GREEN}status check complete${NC} (repositories not listed are up to date)."
}

pull_repo() {
    local target_keys=("$@")
    if [[ "$1" == "all" ]]; then
        target_keys=("${!REPOS[@]}")
    fi

    for key in "${target_keys[@]}"; do
        if [[ -n "${REPOS[$key]}" ]]; then
            echo -e "\n${YELLOW}pulling [$key]...${NC}"
            cd "${REPOS[$key]}" && git pull
        else
            echo -e "${RED}error: keyword '$key' not found.${NC}"
        fi
    done
}

push_repo() {
    if [ $# -lt 2 ]; then
        echo -e "${RED}usage: $0 push <keyword|all> \"commit message\"${NC}"
        return
    fi
    
    local key_input=$1
    local msg=${*:2} 
    
    # one repo or all repos
    local target_keys=("$key_input")
    if [[ "$key_input" == "all" ]]; then
        target_keys=("${!REPOS[@]}")
    fi

    for key in "${target_keys[@]}"; do
        if [[ -n "${REPOS[$key]}" ]]; then
            echo -e "\n${YELLOW}Committing and pushing [$key]...${NC}"
            cd "${REPOS[$key]}" || continue
            
            # check if there are actually changes to commit
            if [[ -n $(git status --porcelain) ]]; then
                git add .
                git commit -m "$msg"
                git push
                echo -e "${GREEN}Successfully pushed [$key].${NC}"
            else
                # if there are no uncommitted changes, check if it just needs to push
                # existing commits (ahead of remote)
                BRANCH=$(git rev-parse --abbrev-ref HEAD)
                REMOTE=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)
                AHEAD=$(git rev-list --left-right --count $BRANCH...$REMOTE 2>/dev/null | awk '{print $1}')
                
                if [[ "$AHEAD" -gt 0 ]]; then
                    git push
                    echo -e "${GREEN}successfully pushed existing commits for [$key].${NC}"
                else
                    echo -e "nothing to commit or push for [$key]."
                fi
            fi
        else
            echo -e "${RED}error: '$key' not found.${NC}"
        fi
    done
}

case "$1" in
    status)
        check_status
        ;;
    pull)
        shift
        pull_repo "$@"
        ;;
    push)
        shift
        push_repo "$@"
        ;;
    *)
        echo -e "custom git repo manager"
        echo -e "available keywords: ${YELLOW}${!REPOS[@]}${NC}\n"
        echo -e "usage:"
        echo -e "  $0 status                           # check all repos for changes"
        echo -e "  $0 pull <key1> <key2> | all         # pull selected repos, or all"
        echo -e "  $0 push <key|all> \"commit message\"  # commit and push a specific repo, or all"
        exit 1
        ;;
esac
