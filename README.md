# Dotfiles

Configurações pessoais do meu ambiente Linux, mantidas no Git e aplicadas ao sistema por meio de links simbólicos.

Este repositório foi desenvolvido para uso no **Debian 13 (Trixie) com GNOME**. Os scripts e pacotes podem precisar de ajustes para funcionar em outras distribuições ou versões.

<p align="center">
  <img width="948" alt="Visão geral do ambiente" src="https://github.com/user-attachments/assets/218ce8f4-f51c-46f3-a12b-2b28d4a5f8f6" />
</p>

<p align="center">
  <img width="989" alt="Terminal e ferramentas do ambiente" src="https://github.com/user-attachments/assets/ed7bbd5b-032e-4003-a7e8-9a2cf5fabbe8" />
</p>

## Ambiente

* **Sistema:** Debian 13 (Trixie)
* **Desktop:** GNOME
* **Shell:** Zsh e Bash
* **Terminal:** Kitty
* **Editor:** Neovim
* **Prompt:** Starship
* **Gerenciamento:** scripts Bash e links simbólicos

## Estrutura

```text
linux/
├── dotfiles/
│   ├── .config/
│   │   ├── fastfetch/
│   │   ├── htop/
│   │   ├── kitty/
│   │   ├── nvim/
│   │   └── ranger/
│   ├── .bashrc
│   └── .zshrc
├── scripts/
│   ├── dev.sh
│   ├── install.sh
│   └── sync.sh
└── README.md
```

## Dependências

Antes de começar, é necessário ter:

* Debian 13 ou sistema compatível com `apt`;
* acesso à internet;
* Git instalado;
* usuário com permissão para executar `sudo`.

```bash
sudo apt update
sudo apt install -y git
```

## Instalação

Clone o repositório no local utilizado pelas configurações:

```bash
mkdir -p ~/.git
git clone https://github.com/SamuBheckma/linux.git ~/.git/linux
cd ~/.git/linux
```

Execute o setup e selecione a opção desejada no menu:

```bash
bash setup.sh
```

O menu permite instalar os pacotes essenciais, instalar ferramentas adicionais de desenvolvimento, sincronizar os dotfiles ou executar todas essas etapas em sequência.

Se preferir, cada etapa também pode ser executada diretamente:

```bash
bash scripts/install.sh
bash scripts/dev.sh
bash scripts/sync.sh
```

O Docker é opcional e o script perguntará antes de instalá-lo.

## Aplicando as configurações

Execute a sincronização:

```bash
cd ~/.git/linux
bash scripts/sync.sh
```

O script cria links simbólicos entre os arquivos de `dotfiles/` e seus respectivos destinos no diretório pessoal.

> [!WARNING]
> A sincronização substitui intencionalmente os arquivos e diretórios que já existam no destino. Alterações locais que não estejam salvas no repositório serão removidas.

Depois da sincronização, encerre a sessão e entre novamente ou reinicie o terminal para carregar as alterações.

## Como a sincronização funciona

Os arquivos reais permanecem dentro do repositório. O sistema acessa esses arquivos pelos links simbólicos criados no `$HOME` e em `~/.config`.

```text
~/.zshrc        → ~/.git/linux/dotfiles/.zshrc
~/.config/nvim  → ~/.git/linux/dotfiles/.config/nvim
~/.config/kitty → ~/.git/linux/dotfiles/.config/kitty
```

Como os destinos são links, editar uma configuração pelo caminho normal também modifica o arquivo versionado no repositório.

## Atualizando o ambiente

Para receber alterações do repositório:

```bash
cd ~/.git/linux
git pull --ff-only
bash scripts/sync.sh
```

Para salvar alterações feitas localmente:

```bash
cd ~/.git/linux
git status
git diff
git add dotfiles scripts README.md
git commit -m "chore: atualiza configurações"
git push origin main
```

Revise sempre o resultado de `git status` e `git diff` antes de criar o commit.

## Manutenção

As configurações deste repositório refletem meu ambiente pessoal. Antes de executar os scripts em outra máquina, revise:

* os pacotes instalados;
* os caminhos presentes nas configurações;
* os programas disponíveis no sistema;
* os arquivos que serão substituídos pela sincronização.

## Licença

Projeto de uso pessoal. Reutilize e adapte por sua conta e risco.
