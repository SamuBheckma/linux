# ⚙️ dotfiles

Meu ambiente de desenvolvimento Linux automatizado e sincronizado via links simbólicos.

![Demonstração do terminal ou screenshot do setup (Opcional)](https://placeholder.com)

## 🚀 Como Instalar (Quick Start)

Para instalar todo o ambiente em uma máquina recém-formatada, clone o repositório e execute o script de instalação:

```bash
git clone https://github.com ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

> ⚠️ **Aviso:** O script de sincronização irá sobrescrever os arquivos de configuração padrão do sistema (como `.bashrc`, `.zshrc`, etc.) pelos links simbólicos do repositório.

## 📦 O que está incluído?

*   **Shell:** Bash / Zsh configurados (com aliases úteis).
*   **Prompt:** Starship / Oh My Zsh (se aplicável).
*   **Editor:** Neovim / Helix (suas configurações dentro de `.config`).
*   **Ferramentas:** Tmux, Git, etc.

## 🛠️ Estrutura do Repositório

*   `dotfiles/`: Pasta contendo todos os arquivos de configuração reais.
    *   `.config/`: Configurações de aplicativos (Nvim, Tmux, Alacritty, etc.).
    *   `.bashrc`, `.zshrc`, etc.: Arquivos de configuração da raiz do usuário.
*   `install.sh`: Script principal que instala dependências do sistema e chama o sync.
*   `sync.sh`: Cria os links simbólicos do repositório para o seu `$HOME`.
*   `lsdev.sh`: Script utilitário para [inserir o propósito do lsdev aqui].

## 🔄 Como funciona a sincronização?

O script `sync.sh` utiliza **links simbólicos** (`ln -sf`). Isso significa que:
1. Os arquivos físicos ficam guardados apenas dentro da pasta `~/dotfiles`.
2. O sistema enxerga esses arquivos no `$HOME` através de atalhos.
3. **Editar no sistema = Editar no repositório.** Qualquer alteração que você fizer nas configurações do seu PC já estará pronta para ser commitada no Git.

## ⚙️ Atualizando os Dotfiles

Se você fizer alterações e quiser levá-las para outra máquina:

```bash
cd ~/dotfiles
git add .
git commit -m "feat: atualiza configurações do tmux"
git push origin main
```

