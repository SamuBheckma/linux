# ~/.bashrc - Configurações do Bash
#
# Este arquivo é lido quando você abre um terminal interativo no Bash.
# Aqui você coloca aliases, funções, variáveis de environment, etc.
#

# ============================================================================
# CORES E VARIÁVEIS DE ENVIRONMENT
# ============================================================================

# Ativar colors em ls, grep, etc
export CLICOLOR=1
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

# Editor padrão
export EDITOR=nvim
export VISUAL=nvim

# ============================================================================
# ALIASES (atalhos úteis)
# ============================================================================

# Navegação
alias ll='ls -lah'
alias la='ls -la'
alias l='ls -CF'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'

# Atalhos para editores
alias v='nvim'
alias vi='nvim'

# Atalhos Git
alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'

# Limpeza
alias c='clear'
alias clr='clear'

# Confirmação antes de delete (safe mode)
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# ============================================================================
# FUNCTIONS (funções personalizadas)
# ============================================================================

# Criar pasta e entrar nela
mkcd() {
  mkdir -p "$1"
  cd "$1"
}

# Extract any archive
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  fi
}

# ============================================================================
# PROMPT (aparência da linha de comando)
# ============================================================================

# Prompt simples e colorido
PS1='\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ '

# Explicação:
# \[\033[1;32m\] = verde bold
# \u = usuário
# \h = hostname
# \w = diretório atual
# \[\033[0m\] = reset cor
# \$ = $ (muda para # se for root)

# ============================================================================
# HISTORY (histórico de comandos)
# ============================================================================

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups

# ============================================================================
# INICIALIZAÇÃO (scripts ao abrir terminal)
# ============================================================================

# Se tiver .bashrc_local, carregar (para configs privadas)
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
