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

# Google Cloud SDK
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# Android Studio
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

# Ruby/rbenv
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
export PATH=$PATH:$HOME/.asdf/shims

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
function agent() {
  setopt local_options no_monitor

  local red="\033[31m"
  local green="\033[32m"
  local blue="\033[34m"
  local magenta="\033[35m"
  local cyan="\033[36m"
  local reset="\033[0m"

  local proj="${(L)${PWD##*/}// /-}"
  local tag="$proj-sandbox"
  local tmpdir=$(mktemp -d)
  trap "rm -rf $tmpdir" EXIT

  cat > "$tmpdir/setup.sh" <<'SCRIPT'
#!/bin/bash
set -e

# Root privilege phase: Fix ownership on volume-mounted directories. Named
# volumes are created as root by Docker, so the claude user can't write to them
# without this. Use the claude user's UID/GID (matching the host user via build
# args) to keep file ownership consistent between the container and the
# host-mounted workspace. Once ownership is fixed, re-exec this same script as
# the claude user via gosu.
if [ "$(id -u)" = "0" ]; then
  CLAUDE_UID=$(id -u claude)
  CLAUDE_GID=$(id -g claude)
  find /workspace -maxdepth 3 -name "node_modules" -type d -exec chown $CLAUDE_UID:$CLAUDE_GID {} \;
  chown -R $CLAUDE_UID:$CLAUDE_GID /home/claude/gopath 2>/dev/null || true
  chown -R $CLAUDE_UID:$CLAUDE_GID /home/claude/.cache 2>/dev/null || true
  chown -R $CLAUDE_UID:$CLAUDE_GID /home/claude/.nvm 2>/dev/null || true
  chown -R $CLAUDE_UID:$CLAUDE_GID /home/claude/.pnpm-store 2>/dev/null || true
  exec gosu claude "$0" "$@"
fi

# Project setup phase (running as claude user).
cd /workspace

# Go
if [ -f go.mod ]; then
  GO_VERSION=$(cat .go-version 2>/dev/null || echo "1.26.0")
  if ! go version 2>/dev/null | grep -q "go${GO_VERSION}"; then
    echo -ne "  Initializing \033[36mGo v$GO_VERSION\033[0m project..."
    curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz" | tar -C /home/claude -xz > /dev/null 2>&1
    export PATH="/home/claude/go/bin:$PATH"
    export GOPATH="/home/claude/gopath"
    go mod tidy > /dev/null 2>&1
    echo -e "\r\033[K\033[32m✓\033[0m Initializing \033[36mGo v$GO_VERSION\033[0m project... \033[32mOK\033[0m"
  else
    echo -ne "  Initializing \033[36mGo\033[0m project with default version \033[36mv$GO_VERSION\033[0m..."
    export PATH="/home/claude/go/bin:$PATH"
    export GOPATH="/home/claude/gopath"
    echo -e "\r\033[K\033[32m✓\033[0m Initializing \033[36mGo\033[0m project with default version \033[36mv$GO_VERSION\033[0m... \033[32mOK\033[0m"
  fi
fi

# Node
if [ -f package.json ]; then
  if [ -f .node-version ]; then
    NODE_VERSION=$(cat .node-version 2>/dev/null || echo "22")
    export NVM_DIR="/home/claude/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
      . "$NVM_DIR/nvm.sh"
    else
      curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash > /dev/null 2>&1
      . "$NVM_DIR/nvm.sh"
    fi
    if [ "$(node -v 2>/dev/null)" != "v${NODE_VERSION}" ]; then
      nvm install "$NODE_VERSION" > /dev/null 2>&1
    fi
  fi
  if [ -f pnpm-lock.yaml ]; then
    echo -ne "  Initializing \033[36mNode v$NODE_VERSION\033[0m project using \033[35mpnpm\033[0m..."
    export COREPACK_ENABLE_AUTO_PIN=0
    export COREPACK_ENABLE_DOWNLOAD_PROMPT=0
    corepack enable pnpm > /dev/null 2>&1
    pnpm config set store-dir /home/claude/.pnpm-store > /dev/null 2>&1
    [ -d "node_modules/.pnpm" ] || pnpm i --force > /dev/null 2>&1
    echo -e "\r\033[K\033[32m✓\033[0m Initializing \033[36mNode v$NODE_VERSION\033[0m project using \033[35mpnpm\033[0m... \033[32mOK\033[0m"
  elif [ -f package-lock.json ]; then
    echo -ne "  Initializing \033[36mNode v$NODE_VERSION\033[0m project using \033[35mnpm\033[0m..."
    npm ci > /dev/null 2>&1
    echo -e "\r\033[K\033[32m✓\033[0m Initializing \033[36mNode v$NODE_VERSION\033[0m project using \033[35mnpm\033[0m... \033[32mOK\033[0m"
  elif [ -f yarn.lock ]; then
    echo -ne "  Initializing \033[36mNode v$NODE_VERSION\033[0m project using \033[35myarn\033[0m..."
    npm i -g yarn > /dev/null 2>&1
    yarn > /dev/null 2>&1
    echo -e "\r\033[K\033[32m✓\033[0m Initializing \033[36mNode v$NODE_VERSION\033[0m project using \033[35myarn\033[0m... \033[32mOK\033[0m"
  else
    echo -ne "  Initializing \033[36mNode v$NODE_VERSION\033[0m project using \033[35mnpm\033[0m..."
    npm i > /dev/null 2>&1
    echo -e "\r\033[K\033[32m✓\033[0m Initializing \033[36mNode v$NODE_VERSION\033[0m project using \033[35mnpm\033[0m... \033[32mOK\033[0m"
  fi
fi

# Hand off to the command passed via Docker CMD (i.e. `claude`)
exec "$@"
SCRIPT

  cat > "$tmpdir/Dockerfile" <<'DOCKERFILE'
FROM node:22

ARG UID=1000
ARG GID=1000
ARG CLAUDE_VERSION=latest

RUN apt-get update && apt-get install -y bash-completion jq htop curl git gosu && rm -rf /var/lib/apt/lists/*
RUN groupadd -g $GID claude 2>/dev/null || true
RUN useradd -m -s /bin/bash -u $UID -g $GID claude

USER claude
WORKDIR /tmp
RUN curl -fsSL https://claude.ai/install.sh | bash -s -- $CLAUDE_VERSION
ENV PATH="/home/claude/.local/bin:${PATH}"

USER root
COPY --chown=claude:claude setup.sh /home/claude/setup.sh
RUN chmod +x /home/claude/setup.sh

WORKDIR /workspace
ENTRYPOINT ["/home/claude/setup.sh"]
DOCKERFILE

  # Build the Docker image in the background, passing UID/GID as build args for
  # proper permissions on mounted volumes
  local claude_version=$(curl -s https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/latest)

  docker build --progress=quiet \
    -t $tag \
    --build-arg CLAUDE_VERSION="$claude_version" \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    "$tmpdir" > /dev/null 2>&1 &

  # Display loader while building
  local pid=$!
  local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  while kill -0 $pid 2>/dev/null; do
    for ((i=0; i<${#spin}; i++)); do
      printf "\r${magenta}${spin:$i:1}${reset} Building ${red}Claude Code v$claude_version${reset} sandbox ${cyan}$tag${reset}..."
      sleep 0.1
    done
  done
  wait $pid
  printf "\r\033[K${green}✓${reset} Building ${red}Claude Code v$claude_version${reset} sandbox ${cyan}$tag${reset}... ${green}OK${reset}\n"

  # Set up Docker args based on project type
  local is_go=$([ -f go.mod ] && echo 1 || echo 0)
  local is_node=$([ -f package.json ] && echo 1 || echo 0)
  local -a docker_args=()
  if (( is_go )); then
    docker_args+=(-v "${proj}-gopath:/home/claude/gopath")
    docker_args+=(-v "${proj}-gobuildcache:/home/claude/.cache/go-build")
    docker_args+=(-e "GOFLAGS=-p=4")
  fi
  if (( is_node )); then
    docker_args+=(-v "${proj}-nvm:/home/claude/.nvm")
    docker_args+=(-v "${proj}-pnpm-store:/home/claude/.pnpm-store")
    for pkg in $(find . -name "package.json" -not -path "*/node_modules/*" -exec dirname {} \;); do
      local rel="${pkg#./}"
      if [ "$rel" = "." ] || [ -z "$rel" ]; then
        docker_args+=(-v "${proj}-nm-root:/workspace/node_modules")
      else
        docker_args+=(-v "${proj}-nm-${rel//\//-}:/workspace/${rel}/node_modules")
      fi
    done
  fi

  # Set up Claude args
  local claude_args=""
  [[ "$1" == "-s" ]] && claude_args="--dangerously-skip-permissions"

  # Run the container
  docker run -it --rm \
    ${ANTHROPIC_API_KEY:+-e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY"} \
    --network=host \
    -v "$HOME/.claude:/home/claude/.claude" \
    -v "$HOME/.claude.json:/home/claude/.claude.json" \
    -v "$(pwd):/workspace" \
    "${docker_args[@]}" \
    $tag \
    claude $claude_args
}
