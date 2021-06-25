# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=100000000000
SAVEHIST=100000000000	
HISTFILE=~/history


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vim mode in zsh
bindkey -v
export KEYTIMEOUT=1
# Aliases

alias sudo='nocorrect sudo -E '
alias gc="git commit"
alias gch="git checkout"
alias gs="git status"
alias ga="git add"
alias gb="git branch"
alias gp="git push"
alias gf="git fetch"
alias gd="git diff"
alias gl="git log"
alias vim="nvim"

# Edit line in vim buffer with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Sets the nvim as the default editor
export EDITOR='nvim'
export VISUAL='nvim'

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh