#!/usr/bin/env bash
# dev_setup.sh - Configurações extras de desenvolvimento

set -euo pipefail

info(){ echo -e "\033[1;34m[info]\033[0m $*"; }
success(){ echo -e "\033[1;32m[✓]\033[0m $*"; }

# ============== SSH Keys ==============
setup_ssh() {
  info "Configurando SSH"
  
  if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    info "Gerando chave SSH Ed25519"
    ssh-keygen -t ed25519 -C "$(git config user.email)" -f "$HOME/.ssh/id_ed25519" -N ""
    success "SSH key criada: ~/.ssh/id_ed25519"
    echo "Copie a chave pública para GitHub:"
    echo "---"
    cat "$HOME/.ssh/id_ed25519.pub"
    echo "---"
  else
    info "SSH key já existe"
  fi
  
  # Configure SSH agent
  eval "$(ssh-agent -s)" 2>/dev/null || true
  ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null || true
}

# ============== Instalar formatadores ==============
install_formatters() {
  info "Instalando formatadores"
  
  # Python formatters
  pip install --user black pylint flake8 2>/dev/null || warn "Falha ao instalar Python formatters"
  
  # Node formatters (global)
  npm install -g prettier eslint 2>/dev/null || warn "Falha ao instalar Node formatters"
  
  # C/C++ formatter
  if command -v apt-get &>/dev/null; then
    sudo apt-get install -y clang-format 2>/dev/null || true
  fi
  
  success "Formatadores instalados"
}

# ============== Instalar LSP servers ==============
install_lsp() {
  info "Instalando Language Servers"
  
  # Neovim Mason vai instalar automaticamente
  # Mas você pode instalar manualmente também
  
  # Python
  pip install --user python-lsp-server 2>/dev/null || true
  
  # Node
  npm install -g vscode-langservers-extracted 2>/dev/null || true
  
  success "LSP servers instalados"
}

# ============== Git Hooks ==============
setup_git_hooks() {
  info "Configurando Git Hooks"
  
  mkdir -p .git/hooks
  
  # Pre-commit hook para verificar formatação
  cat > .git/hooks/pre-commit << 'EOF'
#!/usr/bin/env bash
# Format Python files before commit
for file in $(git diff --cached --name-only --diff-filter=ACM | grep -E '\.py$'); do
  black "$file" 2>/dev/null || true
  git add "$file"
done
EOF
  
  chmod +x .git/hooks/pre-commit
  success "Git hooks configurados"
}

# ============== Database Tools ==============
install_db_tools() {
  info "Instalando ferramentas de database"
  
  if command -v apt-get &>/dev/null; then
    sudo apt-get install -y postgresql-client mysql-client sqlite3 2>/dev/null || warn "Falha ao instalar DB tools"
  fi
  
  success "DB tools instalados"
}

# ============== Main ==============
main() {
  echo "=== Dev Setup Extras ==="
  
  setup_ssh
  install_formatters
  install_lsp
  install_db_tools
  
  echo ""
  success "Setup extra completo!"
  echo "Para usar Git hooks em um projeto, execute:"
  echo "  cd /path/to/repo && bash $0 --git-hooks"
}

if [ "${1:-}" = "--git-hooks" ]; then
  setup_git_hooks
else
  main
fi
