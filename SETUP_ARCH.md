# Setup Arch Linux

Configuração simples para Arch Linux com Hyprland, Neovim e Alacritty.

## Quick Start

```bash
# 1. Clonar este repositório
git clone https://github.com/SamuBheckma/linux.git ~/.config/dotfiles
cd ~/.config/dotfiles

# 2. Instalar pacotes essenciais
bash install.sh

# 3. Sincronizar dotfiles
bash sync.sh

# 4. (Opcional) Setup de dev tools
bash dev_setup.sh
```

## O que cada script faz

### `install.sh`
Instala pacotes base:
- **Hyprland** - Compositor Wayland rápido
- **Neovim** - Editor de texto modal
- **Alacritty** - Terminal GPU-accelerado
- Ferramentas essenciais (git, base-devel, etc)

### `sync.sh`
Sincroniza dotfiles criando links simbólicos:
- `.bashrc`, `.zshrc`, `.gitconfig` → `$HOME/`
- `.config/nvim` → `~/.config/nvim`
- `.config/hypr` → `~/.config/hypr`
- `.config/alacritty` → `~/.config/alacritty`

### `dev_setup.sh`
Instala ferramentas de desenvolvimento (opcional):
- Node.js (via nvm)
- Python
- Docker

## Estrutura

```
dotfiles/
├── .bashrc              # Configurações bash
├── .zshrc               # Configurações zsh
├── .gitconfig           # Configurações git
└── .config/
    ├── nvim/            # Neovim config
    ├── hypr/            # Hyprland config
    └── alacritty/       # Alacritty config
```

## Dicas

- Edite os arquivos em `dotfiles/` e eles serão refletidos em `$HOME` via links
- Antes de sincronizar, backup seus arquivos existentes se necessário
- Use `git status` para ver mudanças nos dotfiles
