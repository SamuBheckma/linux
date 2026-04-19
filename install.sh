#!/usr/bin/env bash

set -euo pipefail

info() { echo -e "\033[1;34m→\033[0m $*"; }
success() { echo -e "\033[1;32m✓\033[0m $*"; }

info "Instalando pacotes essenciais..."

sudo apt install -y \
  base-devel git neovim \
  zsh kitty \
  curl wget fzf

success "Pacotes base instalados"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

ST_DIR="$ZSH_CUSTOM/themes/spaceship-prompt"
[ ! -d "$ST_DIR" ] && git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ST_DIR" --depth=1

if [ ! -L "$ZSH_CUSTOM/themes/spaceship.zsh-theme" ]; then
  ln -sf "$ST_DIR/spaceship.zsh.theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

[ ! -d "$HOME/.fzf" ] && git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"

[ "$SHELL" != "$(which zsh)" ] && chsh -s "$(which zsh)"

success "Setup concluído! Reinicie o terminal"
