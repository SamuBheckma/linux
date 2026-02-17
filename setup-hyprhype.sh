#!/usr/bin/env bash
#
# setup-hyprhype.sh - Integrar Hyprhype ao seu setup
#
# Este script clona o Hyprhype e integra as configurações
#
# Uso: bash setup-hyprhype.sh
#

set -euo pipefail

# Cores
info() { echo -e "\033[1;34m[info]\033[0m $*"; }
success() { echo -e "\033[1;32m[✓]\033[0m $*"; }
error() { echo -e "\033[1;31m[erro]\033[0m $*" >&2; }

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HYPRHYPE_URL="https://github.com/Shentxt/Hyprhype.git"
HYPRHYPE_TEMP="/tmp/hyprhype-setup"

info "Preparando integração do Hyprhype..."

# 1. Clonar Hyprhype
if [ -d "$HYPRHYPE_TEMP" ]; then
  info "Removendo clone anterior..."
  rm -rf "$HYPRHYPE_TEMP"
fi

info "Clonando Hyprhype (isso pode demorar ~30s)..."
git clone --depth 1 "$HYPRHYPE_URL" "$HYPRHYPE_TEMP" || {
  error "Falha ao clonar Hyprhype"
  exit 1
}

success "Hyprhype clonado!"

# 2. Copiar arquivos para dotfiles
info "Copiando configurações para dotfiles/"

# Copiar hypr config
if [ -d "$HYPRHYPE_TEMP/.config/hypr" ]; then
  info "→ Copiando Hyprland config"
  cp -rf "$HYPRHYPE_TEMP/.config/hypr"/* "$REPO_DIR/dotfiles/.config/hypr/" || true
fi

# Copiar Modus (interface gráfica para Hyprland)
if [ -d "$HYPRHYPE_TEMP/.config/Modus" ]; then
  info "→ Copiando Modus (interface)"
  mkdir -p "$REPO_DIR/dotfiles/.config"
  cp -rf "$HYPRHYPE_TEMP/.config/Modus" "$REPO_DIR/dotfiles/.config/"
fi

# Copiar fish config (opcional)
if [ -d "$HYPRHYPE_TEMP/.config/fish" ]; then
  info "→ Copiando fish config (opcional)"
  mkdir -p "$REPO_DIR/dotfiles/.config/fish"
  cp -rf "$HYPRHYPE_TEMP/.config/fish"/* "$REPO_DIR/dotfiles/.config/fish/" || true
fi

success "Configurações copiadas!"

# 3. Limpar temporário
info "Limpando arquivos temporários..."
rm -rf "$HYPRHYPE_TEMP"

# 4. Próximos passos
echo ""
success "Integração completa!"
echo ""
info "Próximos passos:"
echo "  1. Revisar/editar confusags em: dotfiles/.config/hypr/"
echo "  2. Executar: bash sync.sh"
echo "  3. Fazer commit: git add -A && git commit -m 'Add Hyprhype config'"
echo ""
info "Para instalar dependências do Hyprhype:"
echo "  bash hyprinstall.sh"
echo ""
info "Para usar a interface Modus (se instalado):"
echo "  python ~/.config/Modus/main.py"
