export EDITOR=nvim
export VISUAL=nvim
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_GLOB
setopt PROMPT_SUBST

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

mkcd() {
  mkdir -p "$1" && cd "$1"
}

extract() {
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
}

autoload -Uz compinit && compinit
setopt completealiases
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

SPACESHIP_PROMPT_ORDER=(user dir host git hg exec_time line_sep jobs exit_code char)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

[ -f ~/.zshrc_local ] && source ~/.zshrc_local
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
source $ZSH/oh-my-zsh.sh