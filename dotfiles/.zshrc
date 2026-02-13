# ~/.zshrc - Configurações do Zsh
#
# Zsh é um shell mais moderno que bash com melhor autocomplete
# e plugins mais avançados.
#

# ============================================================================
# PATH E EXPORTS
# ============================================================================

export EDITOR=nvim
export VISUAL=nvim
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# ============================================================================
# OPTIONS (comportamento do Zsh)
# ============================================================================

setopt HIST_IGNORE_DUPS          # Não duplicar no histórico
setopt HIST_FIND_NO_DUPS         # Buscar sem duplicatas
setopt SHARE_HISTORY             # Compartilhar história entre abas
setopt INC_APPEND_HISTORY        # Salvar linha por linha
setopt EXTENDED_GLOB             # Globbing avançado
setopt PROMPT_SUBST              # Expansão de variáveis no prompt

# ============================================================================
# ALIASES (iguais aos do bash, mas Zsh é melhor com autocomplete)
# ============================================================================

alias ll='ls -lah'
alias la='ls -la'
alias l='ls -CF'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'

alias v='nvim'
alias vi='nvim'

alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'

alias c='clear'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# ============================================================================
# FUNCTIONS (funções personalizadas)
# ============================================================================

# Criar e entrar em pasta
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract qualquer arquivo
extract() {
  case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz)  tar xzf "$1" ;;
    *.bz2)     bunzip2 "$1" ;;
    *.rar)     unrar x "$1" ;;
    *.gz)      gunzip "$1" ;;
    *.tar)     tar xf "$1" ;;
    *.zip)     unzip "$1" ;;
    *)         echo "'$1' cannot be extracted" ;;
  esac
}

# ============================================================================
# COMPLETION (autocomplete avançado)
# ============================================================================

# Ativar autocomplete integrado
autoload -Uz compinit
compinit

# Permitir autocomplete para aliases também
setopt completealiases

# Lowercase autocomplete (case-insensitive)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ============================================================================
# PROMPT (linha de comando)
# ============================================================================

# Prompt colorido e informativo
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '

# Explicação:
# %F{green}...%f = verde
# %n = usuário
# %m = máquina
# %~ = diretório atual
# %F{blue}...%f = azul
# $ = prompt

# ============================================================================
# PLUGINS (se usar oh-my-zsh ou similar)
# ============================================================================

# Se oh-my-zsh estiver instalado, descomente:
# source $ZSH/oh-my-zsh.sh

# Plugins populares:
# - git (aliases git)
# - zsh-syntax-highlighting (cores no comando)
# - zsh-autosuggestions (sugestões enquanto digita)

# ============================================================================
# STARTUP
# ============================================================================

# Carregar arquivo local se existir (configs privadas)
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

# Se tiver NVM instalado, carregar
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
