#!/usr/bin/env bash
#
# install.sh - Instalar pacotes essenciais no Arch Linux
#
# Este script instala pacotes para:
# - Hyprland (compositor)
# - Neovim (editor)
# - Terminal (alacritty)
# - Ferramentas essenciais
#
# Uso: bash install.sh
#

set -euo pipefail

# Cores
info() { echo -e "\033[1;34m[info]\033[0m $*"; }
success() { echo -e "\033[1;32m[✓]\033[0m $*"; }
error() { echo -e "\033[1;31m[erro]\033[0m $*" >&2; }

# Verificar se é Arch
if ! command -v pacman &> /dev/null; then
  error "Este script é para Arch Linux (precisa pacman)"
  exit 1
fi

info "Instalando pacotes no Arch Linux..."

# ============================================================================
# COMPOSITOR E DISPLAY
# ============================================================================

info "→ Instalando Hyprland (compositor Wayland)"
sudo pacman -S --noconfirm \
  hyprland \
  hyprlock \
  hypridle \
  waybar \
  rofi

# ============================================================================
# EDITOR E DESENVOLVIMENTO
# ============================================================================

info "→ Instalando Neovim"
sudo pacman -S --noconfirm \
  neovim \
  git \
  base-devel

# ============================================================================
# TERMINAL
# ============================================================================

info "→ Instalando Alacritty (terminal rápido)"
sudo pacman -S --noconfirm \
  alacritty \
  ttf-fira-code

# ============================================================================
# SHELL
# ============================================================================

info "→ Instalando Zsh"
sudo pacman -S --noconfirm zsh

# ============================================================================
# FERRAMENTAS ÚTEIS
# ============================================================================

info "→ Instalando ferramentas"
sudo pacman -S --noconfirm \
  curl \
  wget \
  jq \
  fzf \
  ripgrep \
  bat

# ============================================================================
# APLICAÇÕES OPCIONAIS
# ============================================================================

info "→ Instalando aplicações adicionais"
sudo pacman -S --noconfirm \
  --needed \
  firefox \
  thunar \
  mpv

# ============================================================================

success "Instalação concluída! ✨"
info "Próximos passos:"
info "  1. bash sync.sh          (sincronizar dotfiles)"
info "  2. exec zsh              (mudar de shell)"
info "  3. nvim ~/.config/nvim/init.lua   (editar config)"
