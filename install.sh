#!/usr/bin/env bash

info() { echo -e "\033[1;34m→\033[0m $*"; }
success() { echo -e "\033[1;32m✓\033[0m $*"; }

info "Instalando pacotes essenciais..."

sudo apt install -y \
  base-devel git neovim \
  zsh kitty \
  curl wget

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

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1

ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

[ "$SHELL" != "$(which zsh)" ] && chsh -s "$(which zsh)"

success "Setup concluído! Reinicie o terminal"
