#!/usr/bin/env bash

install_lunarvim() {
  echo "Installing LunarVim..."
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
  SRC="$HOME/.local/bin/lvim"
  DST="/usr/local/bin/lvim"
  sudo ln -s $SRC $DST
  echo "Installed LunarVim and symlinked $DST to $SRC."
}

install_rust() {
  echo "Installing rust"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source $HOME/.cargo/env
  echo "Rust installed."
}

install_zsh() {
  echo "Installing ZSH..."
  sudo apt install zsh -y
  chsh -s `which zsh`
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

install_volta_npm() {
  curl https://get.volta.sh | bash
  volta install node
  echo "Installed Volta and NodeJS!"
}

install_python3() {
  sudo apt install -y python3 python3-pip
  echo "Installed Python3 and pip!"
}

install_build_deps() {
  sudo apt install -y build-essential libssl-dev git tmux zip unzip
}

install_misc_utils() {
  cargo install zoxide
  cargo install ripgrep
  cargo install fd-find
  cargo install difftastic
  cargo install igrep
  # cargo install --locked jless -- Disabled for now
  cargo install just
  cargo install broot
}

install_iosevka() {
  mkdir -p ~/.fonts
  pushd ~/.fonts
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
  unzip Iosevka.zip
  rm -rf Iosevka.zip
  popd
  echo "Installed Iosevka font..."
}

install_podman() {
  sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_20.04/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
  wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_20.04/Release.key -O- | sudo apt-key add -
  sudo apt update
  sudo apt install -y podman docker-compose
  sudo systemctl enable podman.socket
  sudo systemctl start podman.socket
  sudo usermod -aG docker $USER
  echo "Installed podman and docker-compose"
}

echo "Starting installation..."

install_build_deps
install_volta_npm
install_python3
install_rust
install_sdkman
install_lunarvim
install_misc_utils
install_zsh
install_iosevka
install_podman

echo "Installation complete."
