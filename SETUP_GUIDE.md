# 📖 Guia de Setup em Nova Máquina

Instruções passo a passo para configurar seu ambiente em uma nova máquina Linux.

## ⚡ Setup Rápido (5 minutos)

```bash
# 1. Clone o repositório
git clone https://github.com/SamuBheckma/linux.git
cd linux

# 2. Execute o instalador (requer sudo em alguns pontos)
bash install.sh

# 3. Abra um novo terminal (ou faça logout/login)
exec zsh

# 4. Configure Git com suas credenciais
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@example.com"
```

Pronto! Seu ambiente está configurado.

## 📋 Verificações Pós-Instalação

```bash
# Verifique que tudo foi instalado
zsh --version          # Deve ser >= 5.0
git --version          # Deve estar presente
nvim --version         # Deve estar presente
node --version         # Deve estar presente (via nvm)
yarn --version         # Deve estar presente
docker --version       # Deve estar presente
flatpak --version      # Deve estar presente
i3 --version           # Deve estar presente
alacritty --version    # Deve estar presente
```

## 🎮 Configurações Personalizadas

### 1️⃣ i3 Window Manager

Se usar i3, edite a configuração:

```bash
nvim ~/.config/i3/config
```

Atalhos principais já estão configurados com Mod (Super/Windows):
- `Mod + Return` → Abre Alacritty
- `Mod + d` → Dmenu
- `Mod + j/k/l/h` → Move o cursor
- `Mod + 1-0` → Troca workspace

**Personalize:**
- Cores, tamanho de fonte, gaps
- Aplicações ao iniciar
- Keybindings

Após editar, recarregue com `Mod + Shift + c`.

### 2️⃣ Alacritty Terminal

Edite a configuração:

```bash
nvim ~/.config/alacritty/alacritty.toml
```

Personalize:
- `font.size` → tamanho da fonte
- `colors.primary.background` → cor de fundo
- `window.opacity` → transparência

Alterações são carregadas automaticamente.

### 3️⃣ Neovim IDE

Na primeira vez que abrir Neovim, Lazy instalará todos os plugins (pode levar 2-3 minutos):

```bash
nvim
```

Verá mensagens do Lazy sendo instalados. Deixe completar e depois `:q` para sair.

Depois, abra novamente e tudo deve estar funcionando:

```bash
nvim
```

**Comandos úteis:**
- `<leader>ff` → Find files (Telescope)
- `<leader>fg` → Find text (grep)
- `<leader>fb` → Find buffers
- `<leader>n` → Toggle file tree (NvimTree)
- `<leader>fmt` → Format code

`<leader>` está configurado como `Space`.

### 4️⃣ NVM e Node.js

NVM foi instalado. Para usar:

```bash
# Listar versões disponíveis
nvm list-remote

# Instalar versão LTS específica
nvm install --lts

# Usar uma versão
nvm use lts

# Definir como padrão
nvm alias default lts
```

Yarn já foi instalado globalmente:

```bash
yarn --version
npm install -g yarn  # Atualizar se necessário
```

### 5️⃣ Docker

Docker foi instalado e configurado:

```bash
# Verifique status
docker ps

# Se permissão negada, faça logout/login ou:
newgrp docker
```

Use os aliases configurados:

```bash
dps           # List containers
drun          # Run container
dex <id>      # Exec into container
dcomp         # docker-compose commands
dcleanup      # Clean all containers/images
```

### 6️⃣ Git

Configure suas credenciais:

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

Use os aliases:

```bash
gs            # Status
gc            # Commit
gp            # Push
gl            # Pull
glog          # Log com graph
```

### 7️⃣ Compilação C/C++

Aliases configurados:

```bash
cc file.c         # Compila com -O2 (otimizado)
ccpp file.cpp     # Compila C++ com C++17
ccdbg file.c      # Compila com debug symbols
cclean            # Remove .o e executáveis
```

Use o template Makefile:

```bash
cp dotfiles/Makefile.template ~/myproject/Makefile
# Edite conforme necessário
make
make run
make clean
```

### 8️⃣ Steam e Discord

Foram instalados via Flatpak:

```bash
# Abra do aplicativo menu ou:
flatpak run com.valvesoftware.Steam
flatpak run com.discordapp.Discord

# Atualize se necessário
flatpak update com.valvesoftware.Steam
flatpak update com.discordapp.Discord
```

## 🔄 Atualizar Dotfiles

Se fizer mudanças nos dotfiles:

```bash
cd ~/linux
git add .
git commit -m "Atualizar dotfiles"
git push origin main
```

Para sincronizar em outra máquina:

```bash
cd ~/linux
git pull origin main
bash install.sh  # Re-aplica symlinks
```

## 🛠️ Troubleshooting

### Problema: Zsh não carrega
```bash
# Abra bash e execute:
exec /bin/bash
chsh -s /usr/bin/zsh
```

### Problema: Neovim não encontra LSP
```bash
nvim
:Mason
# Instale os language servers que precisa
```

### Problema: NVM não funciona
```bash
# Adicione ao ~/.zshrc:
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Reabra o terminal
exec zsh
```

### Problema: i3 não inicia
```bash
# Instale explicitamente
sudo apt install i3-wm  # ou pacman -S i3-wm
# Faça logout/login ou restart
```

### Problema: Permissão Docker
```bash
# Você foi adicionado ao grupo docker
# Reabra sessão ou execute:
newgrp docker
# Teste:
docker ps
```

### Problema: Fonte não aparece no Alacritty
```bash
# Verifique se foi instalada:
fc-list | grep -i terminess

# Se não aparecer, instale manualmente:
mkdir -p ~/.local/share/fonts
# Download e coloque os .ttf em ~/.local/share/fonts
fc-cache -fv
```

## 📚 Recursos Úteis

- **i3 Config**: [i3wm.org/docs/](https://i3wm.org/docs/)
- **Neovim**: [neovim.io](https://neovim.io)
- **Lazy.nvim**: [github.com/folke/lazy.nvim](https://github.com/folke/lazy.nvim)
- **Oh My Zsh**: [ohmyz.sh](https://ohmyz.sh/)
- **Docker**: [docs.docker.com](https://docs.docker.com/)
- **NVM**: [github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm)

## 💡 Dicas Rápidas

### Criar projetos rapidamente
```bash
# Node project
mknodeproj myapp
cd myapp
yarn add express

# Python project  
mkpyproj myapp
cd myapp
source venv/bin/activate
pip install requests
```

### Sincronizar Docker com Git
```bash
# .gitignore padrão para Docker
echo "node_modules/" >> .gitignore
echo ".env" >> .gitignore
echo "__pycache__/" >> .gitignore
```

### SSH Keys no novo PC
```bash
# Gere novas chaves
ssh-keygen -t ed25519 -C "seu@email.com"

# Adicione ao GitHub:
cat ~/.ssh/id_ed25519.pub  # Copie e adicione em Settings > SSH Keys
```

---

**Tudo pronto?** Abra um terminal e divirta-se!

```bash
exec zsh
nvim
```
