# SDKMAN.
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Aliases live here.
source $HOME/.aliases.zsh

# Zoxide.
eval "$(zoxide init zsh)"

# ZSH plugin manager.
eval "$(sheldon source)"

# Sharship prompt.
eval "$(starship init zsh)"
