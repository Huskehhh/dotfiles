# SDKMAN.
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Zoxide.
eval "$(zoxide init zsh)"

# ZSH plugin manager.
eval "$(sheldon source)"

# Sharship prompt.
eval "$(starship init zsh)"

# Volta.
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Justfile autocomplete.
eval $(just --completions zsh)

# Atuin shell history.
eval "$(atuin init zsh)"

# Aliases live here.
source $HOME/.aliases.zsh
