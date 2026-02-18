# Dotfiles - Arch Linux + Hyprland + Neovim

Configurações minimalistas e diretas para Arch Linux com Hyprland, Neovim, Zsh e Kitty.

## Filosofia

- **Sem backup local**: Configurações vivem no git, não fazem backup automático
- **Sem complexidade**: Apenas o necessário, fácil de entender e manter
- **Linkagem automática**: Todos os arquivos são linkados (mudanças no repo = mudanças no sistema)
- **Limpeza**: Scripts removem arquivos antigos, mantendo apenas o novo do git

## Quick Start

```bash
git clone https://github.com/SamuBheckma/linux.git
cd linux
bash install.sh      # Instala pacotes (zsh, neovim, kitty, tmux, etc)
bash sync.sh         # Linka configurações
bash dev_setup.sh    # (Opcional) Node, Python, Docker
```

## Estrutura

```
linux/
├── install.sh       # Instala pacotes base e shells
├── sync.sh          # Cria links simbólicos dos dotfiles
├── dev_setup.sh     # Ferramentas de desenvolvimento
└── dotfiles/
    ├── .bashrc      # Aliases e config Bash
    ├── .zshrc       # Config Zsh + Oh My Zsh
    ├── .gitconfig   # Config Git
    ├── .tmux.conf   # Config Tmux
    └── .config/
        ├── hypr/hyprland.conf      # Hyprland (compositor Wayland)
        ├── nvim/init.lua           # Neovim config (puro Lua)
        └── kitty/kitty.conf        # Kitty terminal
```

## O que cada script faz

### install.sh

```
→ Instala pacotes essenciais: base-devel, git, neovim, zsh, kitty, tmux
→ Instala yay (AUR helper)
→ Configura Oh My Zsh com plugins (syntax-highlighting, autosuggestions, spaceship-prompt)
→ Instala fzf
→ Altera shell padrão para Zsh
✓ Você pode usar o terminal com Zsh configurado
```

### sync.sh

```
→ Verifica dotfiles/ e cria links simbólicos para $HOME
→ Remove arquivos antigos (local) e substitui por links
→ Linka todos os arquivos em dotfiles/.*  (ex: .bashrc, .zshrc)
→ Linka configurações em dotfiles/.config/*/ (ex: hypr, nvim, kitty)
✓ Editar arquivo no repo = editar no sistema (pronto para git commit)
```

### dev_setup.sh

```
→ Instala NVM (Node Version Manager) com Node LTS
→ Instala Python e pip
→ Pergunta se você quer instalar Docker
✓ Ambiente de desenvolvimento pronto
```

## Como usar

**Editar configurações**:
```bash
# Editar é direto - os arquivos estão linkados
nvim ~/.config/nvim/init.lua
# Mudanças aparecem no repo automaticamente
git add .
git commit -m "Atualizar config"
```

**Sincronizar em outro computador**:
```bash
git clone https://github.com/SamuBheckma/linux.git
cd linux
bash install.sh
bash sync.sh
```

## Configurações importantes

- Altere `email` e `name` em `dotfiles/.gitconfig`
- Configure teclado em `dotfiles/.config/hypr/hyprland.conf` (kb_layout = br)

## Dependências externas

Hyprland espera:
- `rofi` - menu
- `waybar` - status bar  
- `hypridle` - lock/sleep
- `brightnessctl` - brightness
- `amixer` - audio

Instale com: `sudo pacman -S rofi waybar brightnessctl alsa-utils`

## Notas

- Não há backup automático - tudo é git
- Scripts limpam arquivo de log quando sincronizam
- Editar diretamente no `dotfiles/` para fazer commits
- Use `bash sync.sh` novamente se der problema com links

---

## 🔧 Instalação Arch (Manual)

Este repositório **NÃO** automatiza tudo. Você vai aprender instalando Arch manualmente.

### Passos principais:

1. **Boot do Live USB** com ISO do Arch
2. **Particionar disco** com `fdisk` ou `cfdisk`
3. **Formatar partições** com `mkfs`
4. **Instalar base** com `pacstrap`
5. **Configurar bootloader** (GRUB ou systemd-boot)
6. **Entrar no chroot** e completar setup
7. **Instalar essenciais**: git, networkmanager, hyprland, etc

Use o **Wiki oficial do Arch** para cada passo:
👉 https://wiki.archlinux.org/title/Installation_guide

Depois que Arch estiver pronto, você executa os scripts daqui!

---

## 📖 Scripts Disponíveis

### `sync.sh` - Sincronizador de Dotfiles
```bash
bash sync.sh
```
Cria links simbólicos de `dotfiles/` para seu `$HOME`. Cada arquivo fica sincronizado com o repositório.

### `install.sh` - Instalador de Pacotes (opcional)
```bash
bash install.sh
```
Instala pacotes essenciais no Arch (hyprland, neovim, git, etc).

### `dev_setup.sh` - Setup extras
```bash
bash dev_setup.sh
```
Configurações adicionais (Node.js, Python, Docker, etc).

---

## 📝 Próximas etapas

- [ ] Ler e entender cada script
- [ ] Instalar Arch em uma VM (VirtualBox/QEMU)
- [ ] Testar `sync.sh` em um ambiente seguro
- [ ] Customizar dotfiles para seu gosto
- [ ] Fazer commit e push no seu repositório

---

## 📖 Referências

- **Arch Wiki**: https://wiki.archlinux.org
- **Hyprland Wiki**: https://wiki.hyprland.org
- **Neovim Docs**: https://neovim.io/doc/user/
- **Bash Manual**: https://www.gnu.org/software/bash/manual/
