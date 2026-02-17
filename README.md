# 🐧 Dotfiles: Arch Linux + Hyprland + Neovim

Configuração simples de dotfiles para Arch Linux.

## 📦 O que inclui

- **Hyprland** - Compositor Wayland rápido e leve
- **Neovim** - Editor modal poderoso
- **Alacritty** - Terminal acelerado por GPU
- Automação com bash scripts

## 🚀 Quick Start

```bash
# 1. Clonar repositório
git clone https://github.com/SamuBheckma/linux.git
cd linux

# 2. Instalar pacotes
bash install.sh

# 3. Sincronizar dotfiles
bash sync.sh

# 4. (Opcional) Dev tools
bash dev_setup.sh
```

## 📁 Estrutura

```
linux/
├── README.md              # Este arquivo
├── SETUP_ARCH.md          # Guia de setup para Arch
├── install.sh             # Instala pacotes essenciais
├── sync.sh                # Sincroniza dotfiles com links simbólicos
├── dev_setup.sh           # Setup de tools dev (Node, Python, Docker)
└── dotfiles/              # Seus arquivos de configuração
    ├── .bashrc
    ├── .zshrc
    ├── .gitconfig
    └── .config/
        ├── nvim/          # Neovim config
        ├── hypr/          # Hyprland config
        └── alacritty/     # Alacritty config
```

## 🔗 Como funciona

O script `sync.sh` cria **links simbólicos** entre `dotfiles/` e seu `$HOME`:

```bash
~/.bashrc → dotfiles/.bashrc          (arquivo)
~/.config/nvim → dotfiles/.config/nvim (diretório)
```

Qualquer edição em `dotfiles/` aparece automaticamente em `$HOME/`.

## 📝 Scripts

### `install.sh`
Instala pacotes Arch essenciais com pacman.

### `sync.sh`
Sincroniza dotfiles criando links simbólicos (sem fazer backups - sobrescreve).

### `dev_setup.sh`
Instala ferramentas de desenvolvimento (nvm, python, docker).

## 💡 Dicas

- Edite arquivos em `dotfiles/` para que fiquem prontos para git
- Use `git status` para rastrear mudanças
- Veja [SETUP_ARCH.md](SETUP_ARCH.md) para mais detalhes


---

## 💡 Conceitos Principais

### O que é um Dotfile?

Arquivo que começa com `.` no Linux (oculto por padrão):
- `.bashrc` - Config do Bash
- `.zshrc` - Config do Zsh  
- `.config/nvim/init.lua` - Config do Neovim

**Por que versionar?** Backup + portabilidade + histórico das mudanças.

### Como funciona o `sync.sh`?

```
repositório/dotfiles/.bashrc
           ↓ (ln -s)
~/.bashrc (link simbólico apontando para o repositório)
```

Quando você edita `~/.bashrc`, na verdade edita o arquivo no repositório! 

### Fluxo típico:

1. Editar `~/.config/nvim/init.lua` no seu editor
2. Fazer commit no Git: `git add --all && git commit -m "..."`
3. Push para GitHub: `git push origin main`
4. Em outra máquina: clonar + `bash sync.sh` = tudo sincronizado ✨

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
