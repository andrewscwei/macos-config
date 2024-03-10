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
# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

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

# Google Cloud SDK
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# Android Studio
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

# Ruby/rbenv
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
export PATH=$PATH:$HOME/.asdf/shims

# vpm
alias vpm=". $HOME/.vpm/vpm.sh"

# Go modules
export GO111MODULE=on