#!/usr/bin/env zsh

install_neovim_from_github() {
  curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
  | grep "browser_download_url.*deb" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -

  sudo dpkg -i nvim-linux64.deb
  rm -rf nvim-linux64.deb*
}

install_nvim() {
  install_neovim_from_github
  echo "Installed nvim."
}

install_rust() {
  echo "Installing rust"
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  source "$HOME/.cargo/env"
  echo "Rust installed."
}

install_zsh_plugins() {
  cp .aliases.zsh $HOME/.aliases.zsh
  cp .zshrc $HOME/.zshrc
  cargo binstall sheldon --no-confirm
  mkdir -p $HOME/.config/sheldon/
  cp plugins.toml $HOME/.config/sheldon/plugins.toml

  # Starship prompt.
  cargo binstall starship --no-confirm

  echo "Installed ZSH plugins."
}

install_volta_npm() {
  curl https://get.volta.sh | bash
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
  volta install node
  volta install yarn
  echo "Installed Volta and NodeJS!"
}

install_build_deps() {
  sudo apt update && sudo apt upgrade -y
  sudo apt install -y \
  build-essential \
  libssl-dev \
  git \
  tmux \
  zip \
  unzip \
  curl \
  wget \
  pkg-config \
  cmake \
  clang \
  clangd \
  clang-format \
  python3 \
  python3-pip \
  python3-venv \
  gdbserver \
  gdb
}

install_misc_utils() {
  cargo install cargo-binstall
  cargo binstall zoxide --no-confirm
  cargo binstall ripgrep --no-confirm
  cargo binstall fd-find --no-confirm
  cargo binstall just --no-confirm
  cargo binstall broot --no-confirm
  cargo binstall atuin --no-confirm
  cargo binstall cargo-update --no-confirm
  cargo binstall cargo-sweep --no-confirm
  cargo binstall cargo-edit --no-confirm
  cargo binstall bat --no-confirm
  cargo binstall exa --no-confirm
  cargo binstall cargo-watch --no-confirm
  cargo binstall sccache --no-confirm
  cargo binstall topgrade --no-confirm
}

echo "Starting installation..."

install_build_deps
install_rust
install_misc_utils
install_zsh_plugins
install_volta_npm
install_nvim

echo "Installation complete!"

