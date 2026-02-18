export EDITOR=nvim
export VISUAL=nvim
export CLICOLOR=1
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

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

PS1='\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ '

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups

[ -f ~/.bashrc_local ] && source ~/.bashrc_local
