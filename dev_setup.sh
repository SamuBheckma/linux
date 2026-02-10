#!/usr/bin/env bash
# dev_setup.sh - Configurações essenciais de desenvolvimento

set -euo pipefail

# ============== SSH Keys ==============
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "[info] Gerando chave SSH Ed25519..."
  ssh-keygen -t ed25519 -C "$(git config user.email)" -f "$HOME/.ssh/id_ed25519" -N ""
  echo "[✓] Chave SSH criada"
else
  echo "[info] SSH key já existe"
fi

# ============== Python Tools ==============
echo "[info] Instalando formatadores Python..."
pip install --user black pylint flake8 2>/dev/null || true

# ============== Node Tools ==============
echo "[info] Instalando formatadores Node..."
npm install -g prettier eslint 2>/dev/null || true

# ============== Conclusão ==============
echo "[✓] Setup completo!"
