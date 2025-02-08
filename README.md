# yamlinson/dotfiles

## Using Chezmoi

The files in this repository are intended to be managed by [Chezmoi](https://www.chezmoi.io/).

Initialize the Chezmoi repo on a new machine:
`#alias cm="chezmoi"`
`cm init https://github.com/yamlinson/dotfiles.git`

Check what changes Chezmoi will apply:
`cm diff`

Apply changes:
`cm apply -v`

Edit any tracked file:
`cm edit $FILE`

Pull and apply changes:
`cm update -v`

Untrack a file:
`cm forget $FILE`

## Required packages

### nvim

- ripgrep
- fzf
- lazygit
- node & npm
- rust & cargo
- go

### tmux

- tmux-plugins/tpm
- sesh

### zsh

- zsh-autosuggestions
- zsh-syntax-highlighting
- powerlevel10k
- zoxide
