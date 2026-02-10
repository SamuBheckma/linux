# Dotfiles Linux - Setup Arch + Hyprland

Um repositório de dotfiles minimalista para Arch Linux com Hyprland (compositor Wayland moderno).

## 📦 O que é instalado

### Sistema
- **Arch Linux** pacman
- **Hyprland** compositor Wayland com animações
- **Hyprlock** + **Hypridle** (lock & idle management)
- **Waybar** (status bar moderno)
- **Rofi** (app launcher/switcher)

### Shell & Desenvolvimento
- **Zsh** com Oh My Zsh e plugins (syntax-highlighting, autosuggestions)
- **Neovim** IDE completo (Lazy.nvim, LSP, Treesitter)
- **Git** com configurações úteis
- **Node.js** via NVM (LTS)
- **Python3** com pip
- **Docker** (com usuário no grupo)
- **Flatpak** para aplicações

### Terminal & Interface
- **Alacritty** terminal rápido (tema roxo VS Code-like)
- **FiraCode Nerd Font** (noto)
- Opacity 93%, decorações off


## 🚀 Instalação Rápida

```bash
git clone https://github.com/SamuBheckma/linux.git
cd linux
bash install.sh
```

### Após instalação
```bash
exec zsh                  # Recarregar shell
bash sync.sh              # Link dotfiles (já feito, mas opcional)
bash dev_setup.sh         # Install SSH keys + formatadores (opcional)
```

## 📋 Arquivos de Configuração

```
linux/
├── install.sh                  # Instalador Arch + Hyprland
├── sync.sh                     # Sincronizar dotfiles
├── dev_setup.sh                # SSH key + formatadores (opcional)
├── README.md                   # Este arquivo
├── SETUP_GUIDE.md              # Guia completo
└── dotfiles/
    ├── .zshrc                  # Zsh com aliases
    ├── .gitconfig              # Git config
    ├── .gitignore_global
    ├── .gitmessage
    ├── .env.example
    ├── Makefile.template
    └── .config/
        ├── hyprland/           # Hyprland config (compositor)
        ├── alacritty/
        │   └── alacritty.toml  # Terminal tema roxo
        ├── waybar/             # Status bar
        └── nvim/
            └── init.lua        # Neovim com Lazy.nvim

## 🔧 Cores & Tools

Para personalizar:
- **Cores Alacritty**: `~/.config/alacritty/alacritty.toml` (tema roxo VS Code-like)
- **Hyprland**: `~/.config/hyprland/hyprland.conf`
- **Neovim**: `~/.config/nvim/init.lua`

### Desenvolvimento
```bash
v       # nvim
c       # clear
```

## � Scripts Disponíveis

### `install.sh` - Instalador Principal
Instala tudo automaticamente com detecção de distro:
```bash
bash install.sh
```
- Detecta Debian/Ubuntu, Arch/Manjaro ou Fedora
- Instala todos os pacotes necessários
- Configura NVM, Node, Yarn
- Instala Terminess Nerd Font
- Configura Docker, Flatpak, Steam, Discord
- Cria symlinks de dotfiles
- Muda shell padrão para zsh

### `sync.sh` - Sincronizar Dotfiles
Reaplica symlinks de dotfiles (útil após clonar novamente):
```bash
bash sync.sh         # Apenas sincroniza
bash sync.sh --pull  # Puxa mudanças do Git e sincroniza
```

### `dev_setup.sh` - Setup extra (opcional)
```bash
bash dev_setup.sh
```
SSH key Ed25519 + formatadores Python/Node

## 📖 Documentação

- **README.md** - Este arquivo
- **SETUP_GUIDE.md** - Guia completo

---

Customize em `~/.config/` (hyprland, alacritty, nvim, waybar)
