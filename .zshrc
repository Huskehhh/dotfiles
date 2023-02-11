autoload -Uz compinit
compinit

eval "$(zoxide init zsh)"
eval "$(sheldon source)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

source $HOME/.aliases.zsh
