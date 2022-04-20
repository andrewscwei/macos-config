# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random" it'll load a random theme
# each time that oh-my-zsh is loaded. See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME=""

# Set list of themes to load Setting this variable when ZSH_THEME=random causes zsh to load the
# theme from this variable instead of looking in ~/.oh-my-zsh/themes/. An empty array has no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case sensitive completion must
# be off. _ and - will be interchangeable. HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13m

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots while waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time stamp shown in the
# history command output. You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" or set a custom format using the strftime function format
# specifications, see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration
NVM_AUTO_USE="true"
fpath+=/opt/homebrew/share/zsh/site-functions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*) Custom
# plugins may be added to ~/.oh-my-zsh/custom/plugins/ Example format: plugins=(rails git textmate
# ruby lighthouse) Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-nvm
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# Preferred editor for local and remote SSH sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='nano'
fi

# zsh-completions
autoload -U compinit && compinit

# pure
autoload -U promptinit; promptinit
prompt pure

# Set personal aliases, overriding those provided by oh-my-zsh libs, plugins, and themes. Aliases
# can be placed here, though oh-my-zsh users are encouraged to define aliases within the ZSH_CUSTOM
# folder. For a full list of active aliases, run `alias`.
#
# Example aliases alias zshconfig="mate ~/.zshrc" alias ohmyzsh="mate ~/.oh-my-zsh"
alias vpm=". ~/.vpm/vpm.sh"

# # Python
# alias python=/opt/homebrew/bin/python3
# alias pip=/opt/homebrew/bin/pip3

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

# rbenv
eval "$(rbenv init - zsh)"

# pyenv
export PATH=$(pyenv root)/shims:$PATH
eval "$(pyenv init -)"
