# User configuration
export FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"
export WORDCHARS="~!#$%^&*(){}[]<>?+;-"

# Search through history with up/down arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# zsh-nvm
export NVM_AUTO_USE="true"
source ~/.zsh/zsh-nvm/zsh-nvm.plugin.zsh

# zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Ruby/rbenv
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init - zsh)"

# pyenv
export PATH=$(pyenv root)/shims:$PATH
eval "$(pyenv init -)"

# vpm
alias vpm=". $HOME/.vpm/vpm.sh"
