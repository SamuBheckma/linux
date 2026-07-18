#!/usr/bin/env bash

set -euo pipefail

readonly BLUE='\033[1;34m'
readonly GREEN='\033[1;32m'
readonly RED='\033[1;31m'
readonly NC='\033[0m' # No Color

info() { printf "${BLUE}→${NC} %s\n" "$*"; }
success() { printf "${GREEN}✓${NC} %s\n" "$*"; }
error() { printf "${RED}✗${NC} %s\n" "$*"; >&2; }

info "Iniciando setup de ferramentas de desenvolvimento..."

if [ ! -d "$HOME/.nvm" ]; then
  info "Instalando NVM e Node.js (LTS)..."
  curl -fsSL https://githubusercontent.com | bash

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  nvm install --lts
  success "Node.js (LTS) instalado com sucesso."
else
  info "NVM já detectado no sistema."
fi

info "Atualizando índices de pacotes do sistema..."
sudo apt update -y

info "Garantindo instalação do Python 3 e Pip..."
sudo apt install -y python3 python3-pip

printf "\n"
read -p "Deseja instalar o Docker (docker.io)? (s/N) " -n 1 -r
printf "\n"

if [[ "$REPLY" =~ ^[Ss]$ ]]; then
  info "Instalando Docker..."
  if sudo apt install -y docker.io; then
    sudo systemctl enable --now docker

    sudo groupadd -f docker
    sudo usermod -aG docker "$USER"

    success "Docker instalado com sucesso!"
    info "ATENÇÃO: É necessário fazer LOGOUT ou reiniciar o sistema para usar o docker sem 'sudo'."
  else
    error "Falha ao instalar o pacote docker.io."
  fi
else
  info "Instalação do Docker pulada pelo usuário."
fi

printf "\n"
success "Todo o ambiente de desenvolvimento foi configurado!"
