export ZSH="$HOME/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"
export EDITOR=nvim
export VISUAL=nvim

# Histórico
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# Opções do Zsh
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_GLOB
setopt PROMPT_SUBST
setopt completealiases

# Aliases
alias ll='ls -lah'
alias la='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias v='nvim'
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

# Funções Utilitárias
mkcd() {
  mkdir -p "$1" && cd "$1"
}

extract() {
  if [ -f "$1" ] ; then
	case "$1" in
 	    *.tar.bz2) tar xjf "$1" ;;
	    *.tar.gz)  tar xzf "$1" ;;
    	    *.bz2)     bunzip2 "$1" ;;
    	    *.rar)     unrar x "$1" ;;
    	    *.gz)      gunzip "$1" ;;
    	    *.tar)     tar xf "$1" ;;
    	    *.zip)     unzip "$1" ;;
    	    *)         echo "Cannot extract $1" ;;
  	esac
    else
	echo "'$1' Não é um arquivo válido"
    fi
}

# Plugins do Oh My Zsh
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

# Completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Inicialização do Prompt
eval "$(starship init zsh)"

# Carregamento de scripts locais e ferramentas
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$HOME/.local/bin:$PATH"
