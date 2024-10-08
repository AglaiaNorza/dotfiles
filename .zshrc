export PATH=$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$HOME/.spicetify:$PATH
export EDITOR=$(which nvim)

# ------- misc aliases -------
alias dotfiles='/usr/bin/git --git-dir=/home/aglaia/dotfiles --work-tree=/home/aglaia'
alias edz='nvim ~/.zshrc'
alias edi3='nvim ~/.config/i3/config'
alias bar=~/scripts/switchbar.sh
alias theme=~/scripts/themechange.sh
alias obsi=~/scripts/obsidianise.sh
alias addall='cd -- && cd .config && dotfiles add alacritty i3 i3blocks keyboard nvim yazi backgrounds quotes.txt && cd -- && dotfiles add scripts .zshrc README.md'
alias stfu=shutdown now

# ------- git info: -------
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %b'

setopt PROMPT_SUBST

# checks whether the branch is ahead/behind
autoload -U add-zsh-hook
add-zsh-hook precmd prompt_jnrowe_precmd

# got this function from https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/jnrowe.zsh-theme
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

# ------- prompt: -------
PROMPT='%F{#73daca}%~%f%F{cyan}${vcs_info_msg_0_}${dir_status}%f'

# otherwise this wont fucking work
export SHELL=/usr/bin/zsh

# ------- history -------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# ------- eza (ls alternative) -------
alias ls='eza --icons --color=always'
alias ll='eza -lhma --git-repos --icons --color=always --group-directories-first'
alias la='eza -a --icons --color=always --group-directories-first'
alias l='eza -F --icons --color=always --group-directories-first'
 
# ------- autosuggestions -------
source ~/.config/zsh/autosuggestions/zsh-autosuggestions.zsh

source ~/.config/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# for autocomplete
bindkey -M menuselect  '^[[D' .backward-char  '^[OD' .backward-char
bindkey -M menuselect  '^[[C'  .forward-char  '^[OC'  .forward-char
bindkey              '^I'         menu-complete

# ------- vim-like -------
bindkey -v
export KEYTIMEOUT=1

python ~/scripts/printquote.py

# plugins: autosuggestions, autocomplete, eza
