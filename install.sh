#!/usr/bin/env zsh

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
  cargo binstall pwninit --no-confirm

  pip install --user pwntools
  pip install --user ropper

  pushd $HOME
  git clone https://github.com/pwndbg/pwndbg
  pushd pwndbg
  ./setup.sh
  popd
  popd
}

echo "Starting installation..."

install_build_deps
install_rust
install_misc_utils
install_zsh_plugins
install_volta_npm

echo "Installation complete!"

