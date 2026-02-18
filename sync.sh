#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"

info() { echo -e "\033[1;34m→\033[0m $*"; }
success() { echo -e "\033[1;32m✓\033[0m $*"; }
error() { echo -e "\033[1;31m✗\033[0m $*" >&2; exit 1; }

info "Sincronizando dotfiles..."

[ ! -d "$DOTFILES_DIR" ] && error "Pasta $DOTFILES_DIR não existe"

link_file() {
  local src=$1
  local dst=$2
  
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    return 0
  fi
  
  rm -f "$dst"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  success "Linkado: $(basename "$dst")"
}

link_dir() {
  local src=$1
  local dst=$2
  
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    return 0
  fi
  
  rm -rf "$dst"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  success "Linkado: $(basename "$dst")"
}

for file in "$DOTFILES_DIR"/.??*; do
  [ "$(basename "$file")" = ".git" ] && continue
  [ ! -f "$file" ] && continue
  
  link_file "$file" "$HOME/$(basename "$file")"
done

mkdir -p "$HOME/.config"

for appdir in "$DOTFILES_DIR"/.config/*/; do
  [ ! -d "$appdir" ] && continue
  appname=$(basename "$appdir")
  link_dir "$appdir" "$HOME/.config/$appname"
done

success "Sincronização concluída!"
info "Editar no repo = editar no sistema (pronto para git)"
