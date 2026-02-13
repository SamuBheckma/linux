# 🐧 Dotfiles: Aprendendo Arch + Hyprland + Neovim

Um repositório de dotfiles minimalista para **aprender** a configurar Arch Linux do zero.

## 📚 O que você vai aprender

- ✅ O que são **dotfiles** e por que versionar
- ✅ Instalar **Arch Linux** manualmente (sem archinstall)
- ✅ Configurar **Hyprland** (compositor Wayland)
- ✅ Setup de **Neovim** com Lazy.nvim
- ✅ **Bash scripting** para automação
- ✅ Sincronizar configs com `sync.sh`

## 🚀 Como usar

### 1. Clonar este repositório
```bash
git clone https://github.com/SamuBheckma/linux.git
cd linux
```

### 2. Estudar a estrutura
```
linux/
├── README.md              # Este arquivo
├── install.sh             # Instalador Arch (educativo)
├── sync.sh                # Sincronizador de dotfiles (main script)
├── dev_setup.sh           # Setup de ferramentas dev
└── dotfiles/              # Seus arquivos de configuração
    ├── .bashrc            # Configurações do Bash
    ├── .zshrc             # Configurações do Zsh
    ├── .gitconfig         # Config do Git
    └── .config/           # Pasta de configs de aplicações
        ├── nvim/          # Neovim
        ├── hypr/          # Hyprland
        └── alacritty/     # Terminal
```

### 3. Sincronizar dotfiles (quando já estiver no Arch)
```bash
bash sync.sh
```

Isso vai criar **links simbólicos** de `dotfiles/` para seu `$HOME`.

### 4. Setup de desenvolvimento
```bash
bash dev_setup.sh
```

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
