#!/usr/bin/env zsh

install_dotfiles() {
  cp .aliases.zsh $HOME/.aliases.zsh
  cp .zshrc $HOME/.zshrc
  cp -r .config/* $HOME/.config/
  sheldon lock

  echo "Installed dotfiles."
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
  tealdeer \
  python-pwntools \
  python-ropper
}

install_misc_utils() {
  cargo install pwninit
}

echo "Starting installation..."

install_system_deps
install_misc_utils
install_dotfiles

echo "Installation complete!"

