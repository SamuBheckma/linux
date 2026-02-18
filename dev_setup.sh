#!/usr/bin/env bash

set -euo pipefail

info() { echo -e "\033[1;34m→\033[0m $*"; }
success() { echo -e "\033[1;32m✓\033[0m $*"; }

info "Setup de ferramentas de desenvolvimento"

if [ ! -d "$HOME/.nvm" ]; then
  info "Instalando NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm install --lts
  success "Node.js instalado"
else
  info "NVM já instalado"
fi

info "Instalando Python..."
sudo pacman -Sy --noconfirm python python-pip

read -p "Instalar Docker? (s/n) " -n 1 -r
echo
[[ $REPLY =~ ^[Ss]$ ]] && {
  sudo pacman -S --noconfirm docker
  sudo usermod -aG docker "$USER"
  success "Docker instalado (logout/login necessário)"
} || info "Docker pulado"

success "Desenvolvimento configurado"
