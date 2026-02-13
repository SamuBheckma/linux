# 📁 Pasta `dotfiles/` - Arquivos de Configuração

Esta pasta contém todos os arquivos de configuração que serão sincronizados com `$HOME` via `bash sync.sh`.

## 📖 Como funciona

```
dotfiles/.bashrc
    ↓ (ln -s - symbolic link)
~/.bashrc (aponta para o repositório)
```

Quando você edita `~/.bashrc`, na verdade está editando este arquivo no repositório! 🎯

---

## 📂 Estrutura

### Arquivos Ocultos (raiz)

```
.bashrc            # Config do Bash (shell padrão em muitos sistemas)
.zshrc             # Config do Zsh (shell mais moderno)
.gitconfig         # Config do Git (nome, email, aliases)
```

**Nota**: Arquivos que começam com `.` são ocultos no Linux. Use `ls -la` para vê-los.

### Pasta `.config/` (configs de aplicações)

```
.config/
├── nvim/           # Neovim (editor/IDE)
│   └── init.lua    # Arquivo de configuração principal
│
├── hypr/           # Hyprland (compositor Wayland)
│   └── hyprland.conf
│
└── alacritty/      # Alacritty (terminal)
    └── alacritty.toml
```

**Por que `.config/`?** Padrão XDG (freedesktop.org) - aplicações modernas usam `~/.config/` para guardar configs.

---

## 🎯 Arquivos Explicados

### `.bashrc` - Shell Bash

**O que é?** Configurações que rodam quando você abre um terminal interativo.

**Contém:**
- Aliases (atalhos) - `alias v='nvim'`
- Functions (funções) - `mkcd()` para criar pasta e entrar
- Variáveis - `EDITOR=nvim`
- Prompt customizado

**Quando é carregado?** Toda vez que abrir uma terminal interativa.

---

### `.zshrc` - Shell Zsh

**O que é?** Alternativa mais moderna ao Bash. Melhor autocomplete, melhor history, melhor sintaxe.

**Diferenças do Bash:**
- Autocomplete case-insensitive
- Plugins mais avançados (oh-my-zsh)
- Syntax highlighting nativo
- Sugestões enquanto digita

**Quando usar?** Se preferir um shell mais "fancy" que Bash.

---

### `.gitconfig` - Configurações do Git

**Contém:**
- Informações pessoais (name, email)
- Aliases úteis - `git s` = `git status`
- Cores (git status, log, diff)
- Editor padrão (nvim)
- Comportamento (push, pull, rebase)

**Como editar?**
```bash
# Abrir arquivo
nvim ~/.gitconfig

# Ou editar via git command
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"
```

---

### `.config/nvim/init.lua` - Neovim

**O que é?** Configuração do Neovim (editor modal tipo Vim).

**Contém:**
- Opções do editor (números de linha, identação, etc)
- Keybindings customizados
- Tema/cores
- Statusline
- Preparação para plugins (Lazy.nvim)

**Modos do Vim:**
- **Normal** (ESC): navegação
- **Insert** (i, a, o): escrever
- **Visual** (v): selecionar
- **Command** (:): comandos

**Primeiros passos:**
```bash
# Abrir Neovim
nvim

# Ir pro início do arquivo
gg

# Buscar uma palavra
/search

# Editar (insert modo)
i

# Sair (voltando ao Normal mode)
Esc

# Salvar
:w

# Sair
:q
```

---

### `.config/hypr/hyprland.conf` - Hyprland

**O que é?** Configuração do compositor Wayland (gerenciador de janelas).

**Contém:**
- Resolução do monitor
- Atalhos de teclado (keybindings)
- Layouts (dwindle, master)
- Animações e efeitos
- Regras por aplicação
- Teclado/mouse settings

**Atalhos principais (padrão):**
- `Win+Q` = abrir terminal
- `Win+E` = menu (rofi)
- `Win+C` = fechar janela
- `Alt+1,2,3...` = mudar workspace
- `Win+h,j,k,l` = navegar janelas (vim style)

---

### `.config/alacritty/alacritty.toml` - Terminal Alacritty

**O que é?** Configuração do terminal rápido em Rust.

**Contém:**
- Font (FiraCode)
- Tema (cores)
- Transparência (opacity)
- Atalhos
- Tamanho de janela

**Tema usado:** Catppuccin Mocha (bonito, recomendado)

---

## 🔧 Personalizando

### Adicionar novo arquivo

1. Criar arquivo em `dotfiles/`:
   ```bash
   echo "# Meu arquivo" > dotfiles/.meuarquivo
   ```

2. Executar sync:
   ```bash
   bash sync.sh
   ```

3. Pronto! Arquivo linkado em `~/.meuarquivo`

### Adicionar novo diretório

1. Criar em `dotfiles/.config/`:
   ```bash
   mkdir -p dotfiles/.config/seuapp
   echo "config here" > dotfiles/.config/seuapp/config.txt
   ```

2. Executar sync:
   ```bash
   bash sync.sh
   ```

3. O diretório será linkado em `~/.config/seuapp`

---

## ⚠️ Backup Automático

Se arquivo já existe quando você roda `sync.sh`:
```
~/.bashrc → ~/.bashrc.backup.20260213_153042
```

O arquivo original é preservado com timestamp!

---

## 📝 Fluxo de Trabalho Recomendado

1. **Editar config no editor**:
   ```bash
   nvim ~/.config/nvim/init.lua
   ```

2. **Testar a mudança**:
   ```bash
   # Recarregar Neovim
   :source %
   ```

3. **Commit no Git** (seu repositório):
   ```bash
   cd ~/linux
   git add .config/nvim/init.lua
   git commit -m "Add custom keybindings"
   git push origin main
   ```

4. **Em outra máquina**:
   ```bash
   cd ~/linux
   git pull
   bash sync.sh
   ```

**Resultado**: Configs sincronizadas! ✨

---

## 🎓 Próximos Passos

- [ ] Entender cada arquivo
- [ ] Customizar conforme seu gosto
- [ ] Testar em uma VM (VirtualBox/QEMU)
- [ ] Fazer commit no Git
- [ ] Documentar suas mudanças

---

## 💡 Dicas

- Use `.bashrc_local` / `.zshrc_local` para configs privadas (não versionar)
- Exemplo em `.gitconfig_local` para credenciais
- Teste em uma máquina virtual primeiro!
- Leia comentários nos arquivos - estão bem documentados

Happy dotfiling! 🚀
