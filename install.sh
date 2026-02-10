#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"
TIMESTAMP=$(date +%Y%m%d%H%M%S)

if [ "$EUID" -eq 0 ]; then
  echo "[error] Não rode como root"
  exit 1
fi

# ============== Pacotes Essenciais ==============
echo "[info] Atualizando sistema..."
sudo pacman -Syu --noconfirm

echo "[info] Instalando pacotes..."
sudo pacman -S --noconfirm \
  base-devel cmake pkg-config \
  hyprland hyprlock hypridle waybar rofi alacritty \
  neovim curl git zsh \
  ttf-nerd-fonts-noto fontconfig \
  docker python python-pip \
  xclip wl-clipboard

sudo usermod -aG docker "$USER" 2>/dev/null || true

# ============== NVM + Node + Yarn ==============
echo "[info] Instalando Node.js..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm install --lts
else
  echo "[info] NVM já existe"
fi

# ============== Oh-my-zsh ==============
echo "[info] Instalando oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "[info] oh-my-zsh já existe"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ============== Plugins Zsh ==============
echo "[info] Instalando plugins zsh..."
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# ============== Docker ==============
echo "[info] Habilitando Docker..."
sudo systemctl enable docker 2>/dev/null || true
sudo systemctl start docker 2>/dev/null || true

# ============== Flatpak ==============
echo "[info] Configurando Flatpak..."
sudo systemctl enable flatpak 2>/dev/null || true
sudo systemctl start flatpak 2>/dev/null || true

# ============== Link Dotfiles ==============
if [ -d "$DOTFILES_DIR" ]; then
  echo "[info] Linkando dotfiles..."
  mkdir -p "$HOME/.config"
  
  for dir in hyprland alacritty nvim waybar; do
    src="$DOTFILES_DIR/.config/$dir"
    dst="$HOME/.config/$dir"
    
    if [ -d "$src" ]; then
      if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "$dst.backup.$TIMESTAMP"
      fi
      ln -sf "$src" "$dst"
      echo "[✓] $dst"
    fi
  done
fi

echo ""
echo "[✓] Instalação completa!"
