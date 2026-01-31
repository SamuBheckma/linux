# .zshrc - Configuração completa do Zsh com NVM, Node, Docker, etc.

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
ZSH_THEME="spaceship"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  docker-compose
  npm
  yarn
  nvm
)

# Source oh-my-zsh
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# ============== NVM - Node Version Manager ==============
export NVM_DIR="$HOME/.nvm"
if [ -f "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"
fi
if [ -f "$NVM_DIR/bash_completion" ]; then
  source "$NVM_DIR/bash_completion"
fi

# ============== Colors ==============
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# ============== Terminal ==============
export TERM="xterm-256color"
export EDITOR="nvim"

# ============== PATH ==============
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.nvm/versions/node/*/bin:$PATH"

# ============== Aliases - Geral ==============
alias ll='ls -lah'
alias la='ls -la'
alias l='ls -l'
alias mkdir='mkdir -pv'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'

# ============== Aliases - Git ==============
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate'

# ============== Aliases - Docker ==============
alias d='docker'
alias di='docker images'
alias dc='docker container'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias drun='docker run'
alias dex='docker exec -it'
alias dstop='docker stop'
alias drm='docker rm'
alias drmi='docker rmi'
alias dcomp='docker-compose'
alias dcompup='docker-compose up -d'
alias dcompdown='docker-compose down'
alias dcomplogs='docker-compose logs -f'

# ============== Aliases - Node/Yarn ==============
alias ni='npm install'
alias nid='npm install --save-dev'
alias nr='npm run'
alias nt='npm test'
alias yy='yarn'
alias yi='yarn install'
alias yr='yarn run'
alias yt='yarn test'

# ============== Aliases - Desenvolvimento ==============
alias vi='nvim'
alias vim='nvim'
alias v='nvim'
alias c='clear'
alias h='history'
alias top='htop'

# ============== Aliases - Compilação C/C++ ==============
# Compilação simples sem debug/build files
alias cc='gcc -Wall -Wextra -O2'
alias ccpp='g++ -Wall -Wextra -O2 -std=c++17'
alias ccdbg='gcc -Wall -Wextra -g'
alias ccppdbg='g++ -Wall -Wextra -g -std=c++17'
# Clean files
alias cclean='find . -name "*.o" -delete && find . -name "a.out" -delete && find . -name "*.exe" -delete'

# ============== Spaceship Prompt ==============
SPACESHIP_PROMPT_ORDER=(
  user
  host
  dir
  git
  node
  package
  python
  docker
  exec_time
  line_sep
  battery
  time
  jobs
  exit_code
  char
)

SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_DIR_TRUNC=3
SPACESHIP_GIT_BRANCH_SHOW=true
SPACESHIP_NODE_SHOW=true
SPACESHIP_DOCKER_SHOW=true

# ============== Functions ==============
# Criar novo projeto Node
mknodeproj() {
  local name="${1:-project}"
  mkdir -p "$name"
  cd "$name"
  npm init -y
  mkdir -p src tests
  git init
  echo "node_modules/" > .gitignore
  echo "*.log" >> .gitignore
  echo ".env" >> .gitignore
  echo "Projeto Node '$name' criado com sucesso!"
}

# Criar novo projeto Python
mkpyproj() {
  local name="${1:-project}"
  mkdir -p "$name"
  cd "$name"
  python3 -m venv venv
  source venv/bin/activate
  mkdir -p src tests
  git init
  echo "venv/" > .gitignore
  echo "__pycache__/" >> .gitignore
  echo "*.pyc" >> .gitignore
  echo ".env" >> .gitignore
  echo "Projeto Python '$name' criado com sucesso!"
}

# Docker cleanup
dcleanup() {
  docker ps -aq | xargs docker rm -f
  docker images -q | xargs docker rmi -f
  docker volume ls -q | xargs docker volume rm
  echo "Docker limpado!"
}

# ============== Sourceamentos adicionais ==============
# Source plugins manualmente se necessário
if [ -f "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [ -f "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

