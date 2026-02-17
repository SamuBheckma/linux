# ~/.zshrc


# ============================================================================
# PATH E EXPORTS
# ============================================================================

export EDITOR=nvim
export VISUAL=nvim
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# ============================================================================
# OPTIONS
# ============================================================================

setopt HIST_IGNORE_DUPS          # Não duplicar no histórico
setopt HIST_FIND_NO_DUPS         # Buscar sem duplicatas
setopt SHARE_HISTORY             # Compartilhar história entre abas
setopt INC_APPEND_HISTORY        # Salvar linha por linha
setopt EXTENDED_GLOB             # Globbing avançado
setopt PROMPT_SUBST              # Expansão de variáveis no prompt

# ============================================================================
# ALIASES 
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
# FUNCTIONS
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
# COMPLETION
# ============================================================================

# Ativar autocomplete integrado
autoload -Uz compinit
compinit

# Permitir autocomplete para aliases também
setopt completealiases

# Lowercase autocomplete (case-insensitive)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ============================================================================
# PROMPT 
# ============================================================================

SPACESHIP_PROMPT_ORDER=(
  user # Username section
  dir # Current directory section
  host # Hostname section
  git # Git section (git_branch + git_status)
  hg # Mercurial section (hg_branch + hg_status)
  exec_time # Execution time
  line_sep # Line break
  jobs # Background jobs indicator
  exit_code # Exit code section
  char # Prompt character
)

SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

# ============================================================================
# PLUGINS
# ============================================================================


# Plugins
plugins=(
git
zsh-syntax-highlighting
zsh-autosuggestions
)
# ============================================================================
# STARTUP
# ============================================================================

# Carregar arquivo local se existir (configs privadas)
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

# Se tiver NVM instalado, carregar
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source $ZSH/oh-my-zsh.sh