# User configuration
fpath+=/opt/homebrew/share/zsh/site-functions

# pure
autoload -U promptinit; promptinit
prompt pure

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

# ssh
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='nano'
fi

# OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Android Studio
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

# Google Cloud SDK
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# rbenv
eval "$(rbenv init - zsh)"

# pyenv
export PATH=$(pyenv root)/shims:$PATH
eval "$(pyenv init -)"

# Custom aliases
alias vpm=". ~/.vpm/vpm.sh"
