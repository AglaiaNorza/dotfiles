export PATH=$HOME/.local/bin:$HOME/bin:$PATH
export EDITOR='/home/aglaia/neovim/build/bin/nvim'

#misc aliases
alias oh='xdg-open .'
alias edz='nvim ~/.zshrc'

#git info:
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %b'

setopt PROMPT_SUBST

#checks whether the branch is ahead/behind
autoload -U add-zsh-hook
add-zsh-hook precmd prompt_jnrowe_precmd

prompt_jnrowe_precmd () {
    vcs_info

    if [ -z "${vcs_info_msg_0_}" ]; then
        dir_status=": "
    elif [[ -n "$(git diff --cached --name-status 2>/dev/null )" ]]; then
        dir_status="%F{1} ▶ %f"
    elif [[ -n "$(git diff --name-status 2>/dev/null )" ]]; then
        dir_status="%F{3} ▶ %f"
    else
        dir_status="%F{2} ▶ %f"
    fi
}

#prompt
PROMPT='%F{#73daca}%~%f%F{cyan}${vcs_info_msg_0_}${dir_status}%f'

#otherwise this wont fucking work
export SHELL=/usr/bin/zsh

#history (to save recent commands)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

#colorful ls with icons
source $(dirname $(gem which colorls))/tab_complete.sh
alias lsc='colorls -d'
alias lca='colorls -a'
alias ll='colorls -lA --sd'

#autosuggestion
source ~/.config/zsh/autosuggestions/zsh-autosuggestions.zsh
alias dotfiles='/usr/bin/git --git-dir=/home/aglaia/dotfiles --work-tree=/home/aglaia'
