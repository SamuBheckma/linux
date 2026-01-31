#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Cores
info(){ echo -e "\033[1;34m[info]\033[0m $*"; }
warn(){ echo -e "\033[1;33m[warn]\033[0m $*"; }
err(){ echo -e "\033[1;31m[error]\033[0m $*"; }
success(){ echo -e "\033[1;32m[✓]\033[0m $*"; }

# Detect OS
detect_distro() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$ID"
  elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    echo "$DISTRIB_ID" | tr '[:upper:]' '[:lower:]'
  else
    echo "unknown"
  fi
}

DISTRO=$(detect_distro)
info "Sistema detectado: $DISTRO"

# Ensure running as normal user
if [ "$EUID" -eq 0 ]; then
  warn "Não é recomendado rodar esse script como root. Saindo.";
  exit 1
fi

# ============== FUNÇÃO: Instalar pacotes por distro ==============
install_packages() {
  case "$DISTRO" in
    ubuntu|debian)
      info "Instalando pacotes (Debian/Ubuntu)"
      sudo apt-get update
      sudo apt-get install -y \
        zsh curl git build-essential cmake pkg-config \
        micro neovim i3 i3-wm i3status i3lock dmenu \
        alacritty x11-xserver-utils xclip xsel \
        fontconfig fonts-liberation fonts-dejavu \
        fuse3 libfuse-3-3 \
        docker.io docker-compose flatpak \
        gcc g++ make gdb \
        python3 python3-pip python3-venv
      sudo usermod -aG docker "$USER" 2>/dev/null || warn "Não foi possível adicionar ao grupo docker"
      ;;
    arch|manjaro)
      info "Instalando pacotes (Arch/Manjaro)"
      sudo pacman -Syu --noconfirm
      sudo pacman -S --noconfirm \
        zsh curl git base-devel cmake pkg-config \
        neovim micro i3-wm i3-gaps i3status i3lock dmenu \
        alacritty xorg-xset xclip xsel \
        fontconfig ttf-liberation ttf-dejavu \
        fuse3 \
        docker docker-compose flatpak \
        gcc make gdb \
        python python-pip
      sudo usermod -aG docker "$USER" 2>/dev/null || warn "Não foi possível adicionar ao grupo docker"
      # Multilib
      if ! grep -q "^\[multilib\]" /etc/pacman.conf 2>/dev/null; then
        sudo sed -i '/^#\[multilib\]/,/^#Include/s/^#//' /etc/pacman.conf 2>/dev/null || warn "Falha ao habilitar multilib"
        sudo pacman -Syu --noconfirm
      fi
      ;;
    fedora)
      info "Instalando pacotes (Fedora)"
      sudo dnf update -y
      sudo dnf install -y \
        zsh curl git gcc g++ cmake make pkg-config \
        neovim micro i3 i3-gaps i3status i3lock dmenu \
        alacritty xorg-x11-utils xclip \
        fontconfig liberation-fonts dejavu-fonts \
        fuse-libs \
        docker docker-compose flatpak \
        gdb python3-devel python3-pip
      sudo usermod -aG docker "$USER" 2>/dev/null || warn "Não foi possível adicionar ao grupo docker"
      # Enable RPM Fusion repositories (nonfree, etc)
      sudo dnf install -y rpmfusion-free-release rpmfusion-nonfree-release
      ;;
    *)
      warn "Distro não suportada: $DISTRO. Instale manualmente os pacotes."
      ;;
  esac
}

# ============== FUNÇÃO: Instalar Nerd Font ==============
install_nerdfont() {
  info "Instalando Terminess Nerd Font"
  mkdir -p "$HOME/.local/share/fonts"
  cd "$HOME/.local/share/fonts"
  
  if [ ! -f "Terminess Nerd Font Complete.ttf" ]; then
    # Download da Terminess Nerd Font
    curl -fLo "Terminess.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Terminus.zip" 2>/dev/null || warn "Falha ao baixar Terminess"
    unzip -o "Terminess.zip" *.ttf 2>/dev/null || warn "Falha ao extrair fonts"
    rm -f "Terminess.zip"
    fc-cache -fv 2>/dev/null || warn "fc-cache não disponível"
    success "Terminess Nerd Font instalada"
  else
    info "Terminess Nerd Font já presente"
  fi
}

# ============== FUNÇÃO: Instalar NVM + Node + Yarn ==============
install_nvm_node_yarn() {
  info "Instalando NVM, Node.js e Yarn"
  
  export NVM_DIR="$HOME/.nvm"
  if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts
  else
    info "NVM já instalado"
  fi
  
  # Yarn global
  if ! command -v yarn &>/dev/null; then
    npm install -g yarn
    success "Yarn instalado globalmente"
  else
    info "Yarn já presente"
  fi
}

# ============== FUNÇÃO: Configurar Docker ==============
configure_docker() {
  info "Configurando Docker"
  sudo systemctl enable docker 2>/dev/null || true
  sudo systemctl start docker 2>/dev/null || true
  success "Docker configurado"
}

# ============== FUNÇÃO: Instalar Flatpak ==============
configure_flatpak() {
  info "Configurando Flatpak"
  sudo systemctl enable flatpak 2>/dev/null || true
  sudo systemctl start flatpak 2>/dev/null || true
  success "Flatpak configurado"
}

# ============== FUNÇÃO: Instalar Steam e Discord ==============
install_steam_discord() {
  info "Instalando Steam e Discord"
  case "$DISTRO" in
    ubuntu|debian)
      sudo apt-get install -y steam discord || warn "Falha ao instalar Steam/Discord via apt"
      flatpak install -y flathub com.valvesoftware.Steam com.discordapp.Discord 2>/dev/null || warn "Falha ao instalar via Flatpak"
      ;;
    arch|manjaro)
      sudo pacman -S --noconfirm steam discord-canary || warn "Falha ao instalar Steam/Discord"
      ;;
    fedora)
      sudo dnf install -y steam discord || warn "Falha ao instalar Steam/Discord"
      ;;
  esac
}

# ============== Main Install Flow ==============
main() {
  install_packages
  install_nerdfont
  install_nvm_node_yarn
  configure_docker
  configure_flatpak
  install_steam_discord
  
  # Install oh-my-zsh (non-interactive)
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Instalando oh-my-zsh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    info "oh-my-zsh já instalado"
  fi
  
  export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  
  # spaceship theme
  if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
    info "Instalando spaceship-prompt"
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
  fi
  
  # plugins
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  fi
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  fi
  
  # Link dotfiles
  if [ -d "$DOTFILES_DIR" ]; then
    info "Criando backups e links simbólicos dos dotfiles"
    for file in "$DOTFILES_DIR"/.*; do
      name=$(basename "$file")
      if [[ "$name" == "." || "$name" == ".." || "$name" == ".git" ]]; then
        continue
      fi
      target="$HOME/$name"
      if [ -e "$target" ] && [ ! -L "$target" ]; then
        backup="$target.backup.$TIMESTAMP"
        warn "Backup: $target -> $backup"
        mv "$target" "$backup"
      fi
      ln -sf "$file" "$target"
    done
  fi
  
  # Link config directories
  for dir in i3 alacritty nvim; do
    if [ -d "$DOTFILES_DIR/.config/$dir" ]; then
      mkdir -p "$HOME/.config"
      if [ -e "$HOME/.config/$dir" ] && [ ! -L "$HOME/.config/$dir" ]; then
        backup="$HOME/.config/$dir.backup.$TIMESTAMP"
        warn "Backup: $HOME/.config/$dir -> $backup"
        mv "$HOME/.config/$dir" "$backup"
      fi
      ln -sf "$DOTFILES_DIR/.config/$dir" "$HOME/.config/$dir"
      success "Linked: $HOME/.config/$dir"
    fi
  done
  
  # Change default shell to zsh
  if [ "$(basename "$SHELL")" != "zsh" ]; then
    if command -v chsh >/dev/null 2>&1; then
      info "Alterando shell padrão para zsh"
      chsh -s "$(command -v zsh)" "$USER" || warn "chsh falhou; troque manualmente"
    fi
  fi
  
  success "Instalação completa!"
  info "Próximas ações:"
  echo "  1. Abra um novo terminal: exec zsh"
  echo "  2. Edite ~/.config/i3/config para seus atalhos"
  echo "  3. Configure ~/.config/alacritty/alacritty.toml (fonte, cores, etc)"
  echo "  4. Execute: nvim para abrir neovim e deixar Lazy instalar plugins"
}

main
