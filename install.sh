#!/usr/bin/env bash

set -euo pipefail

info() { echo -e "\033[1;34m[info]\033[0m $*"; }
success() { echo -e "\033[1;32m[✓]\033[0m $*"; }
error() { echo -e "\033[1;31m[erro]\033[0m $*" >&2; }

# ============================================================================
# EDITOR E DESENVOLVIMENTO
# ============================================================================

info "→ Instalando Base de Desenvolvimento"
sudo pacman -S --noconfirm \
  neovim \
  git \
  base-devel

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo "yay já está instalado. Pulando..."
fi

# ============================================================================
# TERMINAL
# ============================================================================

info "→ Instalando Kitty"
sudo pacman -S --noconfirm \
  kitty

yay -S --noconfirm \
  ttc-monocraft
fc-cache -fv

# ============================================================================

info "→ Instalando Zsh"
sudo pacman -S --noconfirm zsh

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "🚀 Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh já está instalado"
fi

if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Alterando shell padrão para Zsh"
  chsh -s "$(which zsh)"
fi

install_plugin() {
  local repo=$1
  local target=$2
  if [ ! -d "$target" ]; then
    echo "Instalando plugin: $repo"
    git clone "$repo" "$target"
  else
    echo "Plugin já existe: $repo"
  fi
}

install_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
install_plugin https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

if [ ! -d "$HOME/.fzf" ]; then
  echo "Instalando fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
else
  echo "fzf já está instalado"
fi

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

info "→ Instalando aplicações adicionais"
sudo pacman -S --noconfirm \
  --needed \
  firefox \
  thunar \
  mpv

# ============================================================================

success "Instalação concluída!"
