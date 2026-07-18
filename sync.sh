#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"

info() { printf "\033[1;34m→\033[0m %s\n" "$*"; }
success() { printf "\033[1;32m✓\033[0m %s\n" "$*"; }
error() { printf "\033[1;31m✗\033[0m %s\n" "$*" >&2; exit 1; }

info "Sincronizando dotfiles..."
[ ! -d "$DOTFILES_DIR" ] && error "Pasta $DOTFILES_DIR não existe"

link_item() {
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


for file in "$DOTFILES_DIR"/.[!.]*; do
    [ "$(basename "$file")" = ".git" ] && continue
    [ ! -f "$file" ] && continue
    link_item "$file" "$HOME/$(basename "$file")"
done

# 2. Links das pastas dentro de .config
if [ -d "$DOTFILES_DIR/.config" ]; then
    mkdir -p "$HOME/.config"
    for appdir in "$DOTFILES_DIR"/.config/*; do
        [ ! -d "$appdir" ] && continue
        appname=$(basename "$appdir")
        link_item "$appdir" "$HOME/.config/$appname"
    done
fi

success "Sincronização concluída!"
