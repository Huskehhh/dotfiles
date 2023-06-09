#!/usr/bin/env zsh

install_zsh_plugins() {
  cp .aliases.zsh $HOME/.aliases.zsh
  cp .zshrc $HOME/.zshrc
  mkdir -p $HOME/.config/sheldon/
  cp plugins.toml $HOME/.config/sheldon/plugins.toml
  sheldon lock

  echo "Installed ZSH plugins."
}

install_system_deps() {
  sudo pacman -Auy
  yes | sudo pacman -S \
  base-devel \
  openssl \
  git \
  tmux \
  zip \
  unzip \
  curl \
  wget \
  pkg-config \
  cmake \
  clang \
  python \
  python-pip \
  python-virtualenv \
  patchelf \
  elfutils \
  neovim \
  extra/noto-fonts-emoji \
  gdb \
  starship \
  rustup \
  nodejs \
  npm \
  yarn \
  pnpm \
  zoxide \
  ripgrep \
  fd \
  just \
  broot \
  atuin \
  bat \
  exa \
  pwndbg \
  cargo-binstall \
  sheldon \
  tealdeer
}

install_misc_utils() {
  cargo install pwninit

  pip install --user pwntools
  pip install --user ropper
}

echo "Starting installation..."

install_system_deps
install_misc_utils
install_zsh_plugins

echo "Installation complete!"

