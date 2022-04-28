#!/usr/bin/env bash

install_lunarvim() {
  echo "Installing LunarVim..."
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
  echo "Installed LunarVim."
}

install_rust() {
  echo "Installing rust"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source $HOME/.cargo/env
  echo "Rust installed."
}

install_zsh() {
  echo "Installing ZSH..."
  sudo dnf install zsh
  echo "Path to ZSH: $(which zsh)"
  sudo lchsh $USER
  cp .aliases.zsh $HOME/.aliases.zsh
  cp .zshrc $HOME/.zshrc
  
  # Begin zsh plugins installation.
  cargo install --locked sheldon
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

install_misc_utils() {
  cargo install --locked zoxide
  cargo install --locked ripgrep
  cargo install --locked fd-find
  cargo install --locked difftastic
  cargo install --locked igrep
  # cargo install --locked jless -- Disabled for now
  cargo install --locked just
}

echo "Starting installation..."

install_rust
install_sdkman
install_lunarvim
install_misc_utils
install_zsh

echo "Installation complete."
