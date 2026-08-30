#!/usr/bin/env bash

set -euo pipefail

readonly SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPTS_DIR="$SETUP_DIR/scripts"

info() { printf "\033[1;34m→\033[0m %s\n" "$*"; }
error() { printf "\033[1;31m✗\033[0m %s\n" "$*" >&2; }

run_script() {
  local script_name=$1
  local script_path="$SCRIPTS_DIR/$script_name"

  if [ ! -f "$script_path" ]; then
    error "Script não encontrado: $script_path"
    return 1
  fi

  info "Executando scripts/$script_name..."
  bash "$script_path"
}

printf "\nO que você deseja configurar?\n\n"
printf "  1) Instalar pacotes essenciais\n"
printf "  2) Instalar ferramentas de desenvolvimento\n"
printf "  3) Sincronizar dotfiles\n"
printf "  4) Executar o setup completo\n"
printf "  0) Sair\n\n"

read -r -p "Selecione uma opção [0-4]: " option
printf "\n"

case "$option" in
  1)
    run_script "install.sh"
    ;;
  2)
    run_script "dev.sh"
    ;;
  3)
    run_script "sync.sh"
    ;;
  4)
    run_script "install.sh"
    run_script "dev.sh"
    run_script "sync.sh"
    ;;
  0)
    info "Setup cancelado."
    ;;
  *)
    error "Opção inválida: $option"
    exit 1
    ;;
esac
