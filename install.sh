#!/usr/bin/env bash

install_lunarvim() {
  echo "Installing LunarVim..."
  sudo dnf install npm neovim
  mkdir ~/.npm-global
  npm config set prefix '~/.npm-global'
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
  echo "Installed LunarVim."
}

install_rust() {
  echo "Installing rust"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  echo "Rust installed."
}

install_docker() {
  echo "Installing docker..."
  sudo dnf -y install dnf-plugins-core
  sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install docker-ce docker-ce-cli containerd.io

  # Install docker compose
  mkdir -p $HOME/.docker/cli-plugins

  # Get the latest release download url for docker compose from github.
  curl -s https://api.github.com/repos/docker/compose/releases/latest | jq  -c '[.assets[] | select( .name | contains("docker-compose-linux-x86_64"))][0].browser_download_url' \
    | tr -d \" \
    | wget -qi -

  chmod +x docker-compose-linux-x86_64
  mv docker-compose-linux-x86_64 $HOME/.docker/cli-plugins/docker-compose 

  echo "Docker installed."
}

install_zsh() {
  echo "Installing ZSH..."
  sudo dnf install zsh
  chsh -s `which zsh`
  
  # Set up plugins
  echo "Installed ZSH."
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

install_vscode() {
  echo "Installing VS Code..."
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  cat <<EOF | sudo tee /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
  sudo dnf check-update
  sudo dnf install code
  echo "Installed VS Code."
}

echo "Starting installation..."

install_rust
#install_docker
install_sdkman
#install_vscode
#install_lunarvim
install_misc_utils

echo "Installation complete."
