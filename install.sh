#!/usr/bin/env zsh

install_nvim() {
  # Overwrite the 'neovim' binary with the actual latest.
  bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
  sudo ln -s $HOME/.local/bin/nvim /usr/bin/nvim

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

install_zsh_plugins() {
  # Begin zsh plugins installation.
  cp .aliases.zsh $HOME/.aliases.zsh
  cp .zshrc $HOME/.zshrc
  cargo binstall sheldon --no-confirm
  mkdir -p $HOME/.sheldon/
  cp plugins.toml $HOME/.sheldon/plugins.toml

  # Starship prompt.
  cargo binstall starship --no-confirm

  echo "Installed ZSH plugins."
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

install_build_deps() {
  sudo apt update && sudo apt upgrade -y
  sudo apt install -y build-essential libssl-dev git tmux zip unzip curl pkg-config cmake clang python3 python3-pip gdbserver
}

install_misc_utils() {
  cargo install cargo-binstall
  cargo binstall zoxide --no-confirm
  cargo binstall ripgrep --no-confirm
  cargo binstall fd-find --no-confirm
  cargo binstall difftastic --no-confirm
  cargo binstall igrep --no-confirm
  cargo binstall just --no-confirm
  cargo binstall broot --no-confirm
  cargo binstall atuin --no-confirm
  cargo binstall cargo-update --no-confirm
  cargo binstall cargo-sweep --no-confirm
  cargo binstall cargo-edit --no-confirm
  cargo binstall tealdeer --no-confirm
  cargo binstall bat --no-confirm
  cargo binstall exa --no-confirm
  cargo binstall zellij --no-confirm
}

echo "Starting installation..."

install_build_deps
install_rust
install_misc_utils
install_zsh_plugins
install_volta_npm
install_sdkman
install_nvim

echo "Installation complete!"
