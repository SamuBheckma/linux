#!/usr/bin/env bash

set -euo pipefail

readonly BLUE='\033[1;34m'
readonly GREEN='\033[1;32m'
readonly RED='\033[1;31m'
readonly NC='\033[0m' # No Color

info() { printf "${BLUE}→${NC} %s\n" "$*"; }
success() { printf "${GREEN}✓${NC} %s\n" "$*"; }
error() { printf "${RED}✗${NC} %s\n" "$*"; >&2; }

info "Iniciando script de ferramentas de desenvolvimento."

if [ ! -d "$HOME/.nvm" ]; then
  info "I nvm, node."
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.6/install.sh | bash

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  nvm install --lts
  nvm use --lts
  nvm alias default 'lts/*'
  success "Tudo ocorrerá como esperado."
else
  info "nvm já detectado no sistema."
fi



info "I python, pip, venv."
sudo apt update -y
sudo apt install -y python3 python3-venv python3-pip

printf "\n"
read -p "Pretende instalar o docker?" -n 1 -r
printf "\n"

if [[ "$REPLY" =~ ^[SsYy]$ ]]; then
  info "I docker"
  if sudo apt install -y docker.io; then
    sudo systemctl enable --now docker

    sudo groupadd -f docker
    sudo usermod -aG docker "$USER"

    success "Tudo ocorrerá como esperado."
    info "É necessário fazer logout ou reiniciar o sistema para usar o docker sem permissões de superusuário."
  else
    error "Falha ao instalar o pacote docker."
  fi
else
  info "Instalação do docker pulada pelo usuário."
fi

printf "\n"
success "O ambiente de desenvolvimento foi configurado."
