# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/admin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
unsetopt autocd beep nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Options
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Keybinds
bindkey '^I' autosuggest-accept

# User functions
mkcd () { mkdir $1 && cd $1 }

# From Quazar_omega on r/unixporn
# https://www.reddit.com/r/unixporn/comments/sxa02o/comment/hxrpq0m/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
LAST_REPO=""
cd() {
    builtin cd "$@"
    git rev-parse 2>/dev/null
    if [ $? -eq 0 ]; then
        if [ "$LAST_REPO" != $(basename $(git rev-parse --show-toplevel)) ]; then
            onefetch
            LAST_REPO=$(basename $(git rev-parse --show-toplevel))
        fi
    fi
}

# User aliases
alias c="clear"
alias cdg="cd ~/git"
alias cdog="cd /opt/git"
alias apa="ansible-playbook --ask-become-pass"
alias lsa="ls -la"
alias sua="su - admin"
alias trig="tree -aCI '.git'"
alias gfs="git fetch && git status"
alias tmn="tmux new -s"
alias tml="tmux ls"
alias tma="tmux attach"
alias tmt="tmux attach -t"
alias tmk="tmux kill-session"

# Sources
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

