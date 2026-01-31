#!/usr/bin/env bash
# sync.sh - Sincronizar dotfiles do repositório para home

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"
TIMESTAMP=$(date +%Y%m%d%H%M%S)

info(){ echo -e "\033[1;34m[info]\033[0m $*"; }
warn(){ echo -e "\033[1;33m[warn]\033[0m $*"; }
success(){ echo -e "\033[1;32m[✓]\033[0m $*"; }

# Sincronizar dotfiles
sync_dotfiles() {
  info "Sincronizando dotfiles"
  
  for file in "$DOTFILES_DIR"/.*; do
    name=$(basename "$file")
    if [[ "$name" == "." || "$name" == ".." || "$name" == ".git" ]]; then
      continue
    fi
    
    target="$HOME/$name"
    
    # Remove link antigo se existir
    if [ -L "$target" ]; then
      rm -f "$target"
    fi
    
    # Backup de arquivo real
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      backup="$target.backup.$TIMESTAMP"
      warn "Backup: $target -> $backup"
      mv "$target" "$backup"
    fi
    
    # Cria novo link
    ln -sf "$file" "$target"
    success "Linked: $target"
  done
  
  # Config dirs
  for dir in i3 alacritty nvim; do
    if [ -d "$DOTFILES_DIR/.config/$dir" ]; then
      mkdir -p "$HOME/.config"
      
      if [ -L "$HOME/.config/$dir" ]; then
        rm -f "$HOME/.config/$dir"
      fi
      
      if [ -e "$HOME/.config/$dir" ] && [ ! -L "$HOME/.config/$dir" ]; then
        backup="$HOME/.config/$dir.backup.$TIMESTAMP"
        warn "Backup: $HOME/.config/$dir -> $backup"
        mv "$HOME/.config/$dir" "$backup"
      fi
      
      ln -sf "$DOTFILES_DIR/.config/$dir" "$HOME/.config/$dir"
      success "Linked: $HOME/.config/$dir"
    fi
  done
}

# Update do repositório
update_repo() {
  info "Puxando mudanças do repositório"
  cd "$REPO_DIR"
  git pull origin main || warn "Falha ao fazer pull"
}

# Main
main() {
  echo "=== Dotfiles Sync ==="
  
  if [ "${1:-}" = "--pull" ]; then
    update_repo
  fi
  
  sync_dotfiles
  
  success "Sincronização completa!"
  info "Reabra seu terminal para aplicar mudanças (exec zsh)"
}

main "$@"
