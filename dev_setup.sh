#!/usr/bin/env bash

set -euo pipefail

info() { echo -e "\033[1;34m[info]\033[0m $*"; }
success() { echo -e "\033[1;32m[✓]\033[0m $*"; }
error() { echo -e "\033[1;31m[erro]\033[0m $*" >&2; }

# ============================================================================
# NODE via NVM
# ============================================================================

if [ ! -d "$HOME/.nvm" ]; then
  info "Instalando NVM"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  

  info "Instalando Node LTS..."
  nvm install --lts
  nvm use --lts
  
  success "Node.js instalado!"
else
  info "NVM já instalado"
fi

# ============================================================================
# PYTHON E PIP
# ============================================================================

info "Instalando Python e pip..."
sudo pacman -S --noconfirm python python-pip

success "Python setup completo"

# ============================================================================
# DOCKER
# ============================================================================

read -p "Instalar Docker? (s/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
  info "Instalando Docker..."
  sudo pacman -S --noconfirm docker
  
  info "Adicionando user ao grupo docker..."
  sudo usermod -aG docker "$USER"
  
  success "Docker instalado! (voce precisa dar logout e login)"
fi

# ============================================================================

success "Comcluído! Reinicie o terminal para aplicar as mudanças."