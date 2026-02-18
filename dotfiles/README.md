# Dotfiles - Configurações

Arquivos de configuração para Arch Linux com Hyprland, Neovim, Zsh, Kitty e Tmux.

## Estrutura

```
dotfiles/
├── .bashrc          # Aliases e funções para Bash
├── .zshrc           # Config Zsh + Oh My Zsh
├── .gitconfig       # Config Git (name, email, aliases)
├── .tmux.conf       # Config Tmux (prefix, keybindings)
└── .config/
    ├── hypr/        # Hyprland compositor Wayland
    ├── nvim/        # Neovim editor
    └── kitty/       # Kitty terminal
```

## Arquivos importantes

### .bashrc
Aliases e funções do Bash. Inclui:
- Atalhos (ll, la, v, gst, etc)
- Função `mkcd()` para criar e entrar em pasta
- Função `extract()` para descompactar arquivos

### .zshrc
Config Zsh com Oh My Zsh. Inclui:
- Mesmos aliases do Bash
- Autocomplete
- Spaceship prompt
- Plugins: git, zsh-syntax-highlighting, zsh-autosuggestions

### .gitconfig
Config Git com aliases úteis:
- `st` = status, `s` = status curto
- `a` = add, `c` = commit, `p` = push
- `l` = log, `d` = diff
- Cores e configurações de merge

### .tmux.conf
Config Tmux:
- Prefix = Ctrl+a
- Mouse support
- Split com | e -
- Navigate com Ctrl+hjkl
- Reload com Ctrl+a r

### .config/hypr/hyprland.conf
Hyprland compositor:
- Variáveis (Super key, terminal, menu)
- Keybindings (wsusario+hjkl para mover, Alt+num para workspaces)
- Decorações (blur, shadows, animations)
- Volume, brightness, screenshot

### .config/nvim/init.lua
Neovim config puro em Lua:
- Indentação, busca, performance
- Keybindings essenciais (Ctrl+s, Ctrl+hjkl, jj para ESC)
- Auto-trim whitespace
- Status line customizada

### .config/kitty/kitty.conf
Kitty terminal:
- Cores (tema Lain dark)
- Font: Monocraft
- Transparência e blur
- Tab bar style

## Editar

Edite os arquivos aqui. Ao rodar `sync.sh`, tudo será linkado:

```bash
~/.bashrc → $(pwd)/.bashrc
~/.config/nvim → $(pwd)/.config/nvim
~/.config/kitty → $(pwd)/.config/kitty
# ... etc
```

Mudanças são diretas e prontas para git commit.

## Dependências

- **Zsh plugins**: Oh My Zsh instala automaticamente
- **Hyprland extras**: rofi, waybar, hypridle, brightnessctl
- **Kitty font**: Monocraft (opcional, usando fallback se não existir)

Instale com: `sudo pacman -S rofi waybar brightnessctl alsa-utils`
