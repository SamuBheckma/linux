# Dotfiles Linux - Instalador Automático

Um repositório de dotfiles completo para configurar um ambiente Linux pronto para desenvolvimento, com suporte para múltiplas distros (Debian/Ubuntu, Arch/Manjaro, Fedora).

## 📦 O que é instalado

### Shells & Ambiente
- **Zsh** com Oh My Zsh e tema Spaceship
- **Terminess Nerd Font** (font monospace para terminal e i3)
- Plugins: autosuggestions, syntax-highlighting

### Ferramentas de Desenvolvimento
- **Git** com aliases úteis
- **Neovim** configurado como IDE completo com:
  - Lazy.nvim (plugin manager)
  - LSP (Language Server Protocol) para C, C++, Python, JavaScript, TypeScript
  - Treesitter para highlight de sintaxe
  - Telescope para fuzzy finding
  - Formatação automática (conform.nvim)
  - Debugging com DAP
  - Temas (tokyonight)
  - File explorer (nvim-tree)

- **Node.js** via NVM (Node Version Manager)
- **Yarn** instalado globalmente
- **Python3** com pip e venv
- **Compiladores**: GCC, G++, Make, GDB (sem debug files desnecessários)
- **Docker** + Docker Compose (com aliases simples)
- **Flatpak** (com suporte a nonfree, multilib, core, extra)

### Desktop
- **i3** Window Manager (com atalhos Mod4/Super idênticos ao XFCE)
- **Alacritty** terminal rápido e moderno
- **Steam** e **Discord** (via Flatpak ou distro-nativo)

### Compiladores (C/C++)
- Compilação otimizada sem logs gigantes
- `-O2` flags por padrão
- Sem geração de arquivos `.o` ou debug files desnecessários
- Template Makefile incluído

## 🚀 Instalação Rápida

```bash
# Clone este repositório
git clone https://github.com/SamuBheckma/linux.git
cd linux

# Execute o instalador
bash install.sh
```

O script detectará sua distribuição automaticamente e instalará os pacotes necessários.

### Após a instalação
1. **Abra um novo terminal:**
   ```bash
   exec zsh
   ```

2. **Configure o Neovim** (abra-o e deixe Lazy instalar plugins):
   ```bash
   nvim
   ```
   Pode levar alguns minutos na primeira vez.

3. **Configure suas credenciais Git:**
   ```bash
   git config --global user.name "Seu Nome"
   git config --global user.email "seu@email.com"
   ```

4. **Leia o guia completo:**
   ```bash
   cat SETUP_GUIDE.md
   ```

5. **(Opcional) Execute setup extra de desenvolvimento:**
   ```bash
   bash dev_setup.sh
   ```

## 📋 Arquivos de Configuração

```
linux/
├── .dotfilesrc                 # Referência central de configurações
├── install.sh                  # Instalador principal (detecção automática de distro)
├── sync.sh                     # Script para sincronizar dotfiles
├── dev_setup.sh                # Setup extra de desenvolvimento
├── README.md                   # Este arquivo
├── SETUP_GUIDE.md              # Guia passo a passo completo
└── dotfiles/
    ├── .zshrc                  # Shell Zsh com aliases e funções
    ├── .gitconfig              # Git config com aliases
    ├── .gitignore_global       # Gitignore global (evita build files)
    ├── .gitmessage             # Template para mensagens de commit
    ├── .xinitrc                # Inicialização do X11 com i3
    ├── .env.example            # Template de variáveis de ambiente
    ├── Makefile.template       # Template para compilação C/C++ otimizada
    └── .config/
        ├── i3/
        │   └── config          # i3 window manager (atalhos com Super/Mod4)
        ├── alacritty/
        │   └── alacritty.toml  # Terminal Alacritty (Terminess Nerd Font)
        └── nvim/
            └── init.lua        # Neovim init com Lazy.nvim e IDE setup
```

## 🔧 Aliases Principais

### Git
```bash
gs      # git status
gc      # git commit
gp      # git push
gl      # git pull
glog    # git log com graph
```

### Docker
```bash
d       # docker
dps     # docker ps
drun    # docker run
dex     # docker exec -it
dcomp   # docker-compose
dcompup # docker-compose up -d
```

### Node/Yarn
```bash
ni      # npm install
nr      # npm run
yy      # yarn
yi      # yarn install
```

### Desenvolvimento
```bash
v       # nvim
c       # clear
cc      # gcc com flags de otimização
ccpp    # g++ com C++17
cclean  # limpa .o e executáveis
```

## 🎯 Funções Úteis (Zsh)

```bash
# Criar novo projeto Node com git
mknodeproj myproject

# Criar novo projeto Python com venv
mkpyproj myproject

# Limpar containers e images Docker
dcleanup
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

### `dev_setup.sh` - Setup Extra de Desenvolvimento
Instala ferramentas extras (formatadores, LSP, SSH keys, hooks git):
```bash
bash dev_setup.sh
```

## 📖 Documentação

- **README.md** - Este arquivo (visão geral)
- **SETUP_GUIDE.md** - Guia completo passo a passo de configuração
- **.dotfilesrc** - Referência de arquivos e aplicações instaladas

```
Mod + Return       Terminal
Mod + d            Dmenu (app launcher)
Mod + j/k/l/h      Move cursor
Mod + Shift+j/k... Move janela
Mod + 1-0          Trocar workspace
Mod + r            Modo resize
Mod + f            Fullscreen
Mod + Shift+q      Fechar janela
Mod + Shift+e      Sair do i3
```

## 📝 Distros Suportadas

- ✅ **Debian / Ubuntu** (apt-get)
- ✅ **Arch / Manjaro** (pacman, multilib automático)
- ✅ **Fedora** (dnf, RPM Fusion automático)

O script detecta automaticamente sua distro e usa o package manager correto.

## 🔄 Atualizar Dotfiles

Se fizer mudanças no repositório local:
```bash
cd ~/linux
git add .
git commit -m "atualizar dotfiles"
git push origin main
```

Para aplicar novamente:
```bash
bash install.sh
```

## 🐛 Troubleshooting

**Neovim não encontra LSP?**
```bash
nvim
:MasonInstall clangd pyright tsserver
```

**Zsh não carrega NVM?**
```bash
# Adicione ao final do ~/.zshrc:
source ~/.nvm/nvm.sh
```

**i3 não aparece no login screen?**
```bash
# Instale:
sudo apt install i3-wm (ou pacman -S i3-wm, etc)
```

**Docker permission denied?**
```bash
# Você já foi adicionado ao grupo docker.
# Relogin ou:
newgrp docker
```

## 📚 Recursos

- [i3 documentation](https://i3wm.org/docs/)
- [Neovim docs](https://neovim.io/doc/user/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Oh My Zsh](https://ohmyz.sh/)
- [Docker docs](https://docs.docker.com/)

---

**Customização rápida:**
- Edite `~/.config/i3/config` para atalhos
- Edite `~/.config/alacritty/alacritty.toml` para cores/fonte
- Edite `~/.config/nvim/init.lua` para plugins do Neovim
- Edite `~/.zshrc` para adicionar aliases/funções
