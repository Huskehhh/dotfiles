#!/usr/bin/env bash

install_nvim() {
  # Install neovim latest version
  sudo apt install -y neovim

  # Then overwrite the binary with the latest
  bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
  sudo install neovim $(which neovim)
  rm -rf neovim

  # Now install AstroVim
  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  nvim +PackerSync

  echo "Installed nvim + AstroVim."
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
  cargo install sheldon
  mkdir -p $HOME/.config/sheldon/
  cp plugins.toml $HOME/.config/sheldon/plugins.toml

  # Starship prompt.
  curl -sS https://starship.rs/install.sh | sh

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
  echo "Installed Volta and NodeJS!"
}

install_python3() {
  sudo apt install -y python3 python3-pip
  echo "Installed Python3 and pip!"
}

install_build_deps() {
  sudo apt install -y build-essential libssl-dev git tmux zip unzip curl
}

install_misc_utils() {
  cargo install zoxide
  cargo install ripgrep
  cargo install fd-find
  cargo install difftastic
  cargo install igrep
  cargo install just
  cargo install broot
  cargo install atuin
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

echo "Installation complete."
