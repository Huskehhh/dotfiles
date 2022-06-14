#!/usr/bin/env bash

install_nvim() {
  # Install neovim latest avail version.
  sudo apt install -y neovim

  # Then overwrite the binary with the actual latest.
  bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
  sudo install $HOME/.local/bin/nvim /usr/bin/nvim
  rm -rf neovim

  # Now install AstroVim.
  rm -rf $HOME/.config/nvim
  git clone https://github.com/AstroNvim/AstroNvim $HOME/.config/nvim

  echo "Installed nvim + AstroVim. Run 'nvim +PackerSync' to install all the plugins."
}

install_rust() {
  echo "Installing rust"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source "$HOME/.cargo/env"
  echo "Rust installed."
}

install_zsh() {
  echo "Installing ZSH..."
  sudo apt install zsh -y
  chsh -s `which zsh`
  cp .aliases.zsh $HOME/.aliases.zsh
  cp .zshrc $HOME/.zshrc
  
  # Begin zsh plugins installation.
  cargo install sheldon --locked
  mkdir -p $HOME/.zshrcsheldon/
  cp plugins.toml $HOME/.sheldon/plugins.toml

  # Starship prompt.
  cargo install starship --locked

  echo "Installed ZSH. Log in and log out for it to take effect."
}

install_sdkman() {
  echo "Installing SDKMAN..."
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk install maven
  sdk install gradle
  echo "Installed SDKMAN..."
  echo "A java installation needs to be installed, view the output of 'sdk list java' and install via 'sdk install java <version>'."
}

install_volta_npm() {
  curl https://get.volta.sh | bash
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
  volta install node
  volta install yarn
  echo "Installed Volta and NodeJS!"
}

install_python3() {
  sudo apt install -y python3 python3-pip
  echo "Installed Python3 and pip!"
}

install_build_deps() {
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y build-essential libssl-dev git tmux zip unzip curl pkg-config
}

install_misc_utils() {
  cargo install zoxide --locked
  cargo install ripgrep --locked
  cargo install fd-find --locked
  cargo install difftastic --locked
  cargo install igrep --locked
  cargo install just --locked
  cargo install broot --locked
  cargo install atuin --locked
}

echo "Starting installation..."

install_build_deps
install_volta_npm
install_python3
install_rust
install_sdkman
install_misc_utils
install_nvim
install_zsh

echo "Installation complete!"
