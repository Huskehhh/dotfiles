set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/share/bob/nvim-bin $fish_user_paths

if status is-interactive
    atuin init fish | source
    zoxide init fish | source
end

alias g="git"
alias ga="git add"
alias gd="git diff"
alias gds="git diff --staged"
alias gc="git commit -m"
alias gp="git push"
alias gs="git status"
alias gw="git switch"
alias gu="git restore --staged"
alias co="git checkout"
alias lh="git rev-parse --short HEAD"
alias stash="git stash"
alias drop="git stash drop"

alias py="python3"
alias vim="nvim"
alias n="nvim"
alias ls="lsd"
alias cd="z"
alias sz="source ~/.config/fish/config.fish"
