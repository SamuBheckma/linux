#!/usr/bin/env bash
#
# sync.sh - Sincronizar dotfiles do repositório para $HOME
#
# O que este script faz:
# 1. Cria links simbólicos de dotfiles/ para $HOME
# 2. Mantém suas configurações sincronizadas com o repositório
#
# Uso: bash sync.sh
#

# ============================================================================
# SEGURANÇA: Parar o script se houver erro
# ============================================================================

set -euo pipefail

# set -e   : Sair se qualquer comando falhar (erro = parar)
# set -u   : Sair se variável indefinida for usada (typo = parar)
# set -o pipefail : Se pipe tiver erro, pipe inteiro falha

# ============================================================================
# VARIÁVEIS GLOBAIS
# ============================================================================

# Pega o diretório do script (onde sync.sh está)
# Mesmo que você execute de outro lugar, usa o caminho correto
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Pasta com dotfiles
DOTFILES_DIR="$REPO_DIR/dotfiles"

# ============================================================================
# FUNÇÕES DE SAÍDA (cores e formatação)
# ============================================================================

# Função para imprimir [info] em AZUL
info() {
  echo -e "\033[1;34m[info]\033[0m $*"
  # \033[1;34m = azul bold
  # \033[0m = reset (volta cor normal)
}

# Função para imprimir [warn] em AMARELO
warn() {
  echo -e "\033[1;33m[warn]\033[0m $*"
}

# Função para imprimir [✓] em VERDE
success() {
  echo -e "\033[1;32m[✓]\033[0m $*"
}

# Função para imprimir [erro] em VERMELHO
error() {
  echo -e "\033[1;31m[erro]\033[0m $*" >&2
}

# ============================================================================
# FUNÇÃO PRINCIPAL: Sincronizar dotfiles
# ============================================================================

sync_dotfiles() {
  info "Sincronizando dotfiles de $DOTFILES_DIR"

  # Verificar se pasta dotfiles existe
  if [ ! -d "$DOTFILES_DIR" ]; then
    error "Pasta $DOTFILES_DIR não existe!"
    exit 1
  fi

  info "Processando arquivos ocultos (.*) ..."

  # LOOP 1: Arquivos ocultos (.bashrc, .gitconfig, etc)
  # ============================================================

  for file in "$DOTFILES_DIR"/.*; do
    # basename extrai só o nome (ex: .bashrc)
    name=$(basename "$file")

    # Pular . e .. (diretórios especiais)
    if [[ "$name" == "." || "$name" == ".." || "$name" == ".git" ]]; then
      continue
    fi

    # Caminho final (ex: ~/.bashrc)
    target="$HOME/$name"

    # Criar link simbólico (sobrescreve antigos)
    ln -sf "$file" "$target"
    success "Linkado: $target → $file"
  done

  # LOOP 2: Diretórios em .config/
  # ============================================================

  info "Processando diretórios em .config/ (nvim, hypr, etc) ..."

  # Estes diretórios tem suas próprias configs
  for dir in nvim hypr alacritty; do
    source_dir="$DOTFILES_DIR/.config/$dir"

    # Pular se não existir em dotfiles
    [ ! -d "$source_dir" ] && continue

    # Garantir que ~/.config/ existe
    mkdir -p "$HOME/.config"

    # Caminho final (ex: ~/.config/nvim)
    target="$HOME/.config/$dir"

    # Link do diretório (sobrescreve antigos)
    ln -sf "$source_dir" "$target"
    success "Linkado: $target → $source_dir"
  done

  # ============================================================

  success "✨ Sincronização concluída!"
  info "Arquivos linkados apontam para: $DOTFILES_DIR"
  info "Editar aqui = editar no repositório (pronto para commit!)"
}

# ============================================================================
# FUNÇÃO: Verificar status dos links
# ============================================================================

check_status() {
  info "Status dos links sincronizados:"
  echo ""

  # Verificar links simples
  for link in ~/.bashrc ~/.zshrc ~/.gitconfig; do
    if [ -L "$link" ]; then
      target=$(readlink "$link")
      echo "  ✓ $link → $target"
    elif [ -e "$link" ]; then
      echo "  ! $link (arquivo real, não link)"
    else
      echo "  - $link (não existe)"
    fi
  done

  echo ""

  # Verificar links de diretórios
  for dir in nvim hypr alacritty; do
    link="$HOME/.config/$dir"
    if [ -L "$link" ]; then
      target=$(readlink "$link")
      echo "  ✓ $link → $target"
    elif [ -d "$link" ]; then
      echo "  ! $link (diretório real, não link)"
    else
      echo "  - $link (não existe)"
    fi
  done
}

# ============================================================================
# EXECUTAR
# ============================================================================

# Chamar função principal
sync_dotfiles

echo ""

# Mostrar status (opcional)
check_status

echo ""
success "Pronto! Seus dotfiles estão sincronizados. 🚀"
