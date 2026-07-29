#!/usr/bin/env bash

set -euo pipefail

readonly BLUE='\033[1;34m'
readonly GREEN='\033[1;32m'
readonly NC='\033[0m'

info() { printf "${BLUE}→${NC} %s\n" "$*"; }
success() { printf "${GREEN}✓${NC} %s\n" "$*"; }

info "Atualizando índices de pacotes..."
sudo apt update -y

info "Instalando pacotes essenciais..."
sudo apt install -y \
  build-essential \
  git \
  zsh \
  kitty \
  curl \
  wget \
  htop \
  fastfetch \
  fonts-firacode

success "Pacotes base e fonte Fira Code instalados com sucesso!"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    info "Oh My Zsh já está instalado."
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

info "Configurando plugins do Zsh..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
    info "Instalando tema Spaceship Prompt..."
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    if [ ! -L "$ZSH_CUSTOM/themes/spaceship.zsh-theme" ]; then
        ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    fi
fi

info "Definindo o Zsh como shell padrão..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    success "Shell padrão alterado para Zsh!"
else
    info "Zsh já é o seu shell padrão."
fi

info "Atualizando cache de fontes do sistema..."
fc-cache -f -v > /dev/null

printf "\n"
success "Setup concluído com sucesso! Reinicie o seu terminal ou faça logout."
