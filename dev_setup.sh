#!/usr/bin/env bash
#
# dev_setup.sh - Setup de desenvolvimento (Node.js, Python, Docker)
#
# Este script é OPCIONAL. Instala:
# - Node.js (via nvm)
# - Python
# - Docker
# - Outras ferramentas dev
#
# Uso: bash dev_setup.sh
#

set -euo pipefail

info() { echo -e "\033[1;34m[info]\033[0m $*"; }
success() { echo -e "\033[1;32m[✓]\033[0m $*"; }
error() { echo -e "\033[1;31m[erro]\033[0m $*" >&2; }

# ============================================================================
# NODE.JS via NVM
# ============================================================================

if [ ! -d "$HOME/.nvm" ]; then
  info "Instalando NVM (Node Version Manager)..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  
  # Carregar nvm no shell atual
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  
  info "Instalando Node.js LTS..."
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

# Instaladores Python úteis
info "Instalando ferramentas Python..."
pip install --user \
  black \
  flake8 \
  pylint

success "Python setup completo"

# ============================================================================
# DOCKER (opcional)
# ============================================================================

read -p "Instalar Docker? (s/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
  info "Instalando Docker..."
  sudo pacman -S --noconfirm docker
  
  info "Adicionando user ao grupo docker..."
  sudo usermod -aG docker "$USER"
  
  success "Docker instalado! (vocerá precisa logout/login)"
fi

# ============================================================================

success "Setup de desenvolvimento concluído! ✨"
