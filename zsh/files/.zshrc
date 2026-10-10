# User configuration
export FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"
export WORDCHARS="_"

# Search through history with up/down arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Pure Prompt
autoload -U promptinit; promptinit
prompt pure

# SSH
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="code"
else
  export EDITOR="nano"
fi

# OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Android Studio
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

# Ruby/rbenv
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# asdf
fpath=(${ASDF_DIR}/completions $fpath)
export PATH=$HOME/.asdf/shims:$PATH

# Go modules
export GO111MODULE=on
export ASDF_GOLANG_MOD_VERSION_ENABLED=true

# Colima
export DOCKER_HOST=unix://${HOME}/.colima/default/docker.sock

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# ngrok
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# mu
alias mu='. /Users/mu/.mu/mu.sh'

# Claude Code
alias agent='. /Users/mu/Developer/agent/agent.sh'
