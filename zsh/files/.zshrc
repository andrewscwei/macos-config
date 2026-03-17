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

  local proj="${(L)${PWD##*/}// /-}"
  local tag="$proj-sandbox"
  local extra_flags=""
  [[ "$1" == "-s" ]] && extra_flags="--dangerously-skip-permissions"

  local tmpdir=$(mktemp -d)
  trap "rm -rf $tmpdir" EXIT

  cat > "$tmpdir/entrypoint.sh" <<'SCRIPT'
#!/bin/bash
set -e

CLAUDE_UID=$(id -u claude)
CLAUDE_GID=$(id -g claude)

find /workspace -maxdepth 3 -name "node_modules" -type d -exec chown $CLAUDE_UID:$CLAUDE_GID {} \;
chown -R $CLAUDE_UID:$CLAUDE_GID /home/claude/.nvm 2>/dev/null || true
chown -R $CLAUDE_UID:$CLAUDE_GID /home/claude/.pnpm-store 2>/dev/null || true

exec gosu claude /home/claude/setup.sh "$@"
SCRIPT

  cat > "$tmpdir/setup.sh" <<'SCRIPT'
#!/bin/bash
set -e
cd /workspace

# Go
if [ -f go.mod ]; then
  GO_VERSION=$(cat .go-version 2>/dev/null || echo "1.22.0")
  if ! go version 2>/dev/null | grep -q "go${GO_VERSION}"; then
    echo "Initializing Go project with version $GO_VERSION"
    curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz" | tar -C /home/claude -xz
    export PATH="/home/claude/go/bin:$PATH"
    export GOPATH="/home/claude/gopath"
    go mod tidy
  else
    export PATH="/home/claude/go/bin:$PATH"
    export GOPATH="/home/claude/gopath"
  fi
fi

# Node
if [ -f package.json ]; then
  if [ -f .node-version ]; then
    NODE_VERSION=$(cat .node-version)
    export NVM_DIR="/home/claude/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
      . "$NVM_DIR/nvm.sh"
    else
      curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
      . "$NVM_DIR/nvm.sh"
    fi
    if [ "$(node -v 2>/dev/null)" != "v${NODE_VERSION}" ]; then
      nvm install "$NODE_VERSION"
    fi
  fi
  if [ -f pnpm-lock.yaml ]; then
    export COREPACK_ENABLE_AUTO_PIN=0
    export COREPACK_ENABLE_DOWNLOAD_PROMPT=0
    corepack enable pnpm
    pnpm config set store-dir /home/claude/.pnpm-store
    [ -d "node_modules/.pnpm" ] || pnpm i --force
  elif [ -f package-lock.json ]; then npm ci
  elif [ -f yarn.lock ]; then npm i -g yarn && yarn
  else npm i
  fi
fi

exec "$@"
SCRIPT

  cat > "$tmpdir/Dockerfile" <<'EOF'
FROM node:22-bookworm

ARG UID=1000
ARG GID=1000

RUN apt-get update && apt-get install -y bash-completion jq htop curl git gosu && rm -rf /var/lib/apt/lists/*
RUN groupadd -g $GID claude 2>/dev/null || true
RUN useradd -m -s /bin/bash -u $UID -g $GID claude

USER claude
WORKDIR /tmp
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH="/home/claude/.local/bin:${PATH}"

USER root
COPY --chown=claude:claude entrypoint.sh /home/claude/entrypoint.sh
COPY --chown=claude:claude setup.sh /home/claude/setup.sh
RUN chmod +x /home/claude/entrypoint.sh /home/claude/setup.sh

WORKDIR /workspace
ENTRYPOINT ["/home/claude/entrypoint.sh"]
EOF

  docker build -q -t $tag --build-arg UID=$(id -u) --build-arg GID=$(id -g) "$tmpdir" > /dev/null 2>&1 &

  local pid=$!
  local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  while kill -0 $pid 2>/dev/null; do
    for ((i=0; i<${#spin}; i++)); do
      printf "\r\033[35m${spin:$i:1}\033[0m Building Claude Code sandbox \033[36m$tag\033[0m..."
      sleep 0.1
    done
  done
  wait $pid
  printf "\r\033[K\033[32m✓\033[0m Building Claude Code sandbox \033[36m$tag\033[0m... \033[32mOK\033[0m\n"

  local -a vol_args=()
  if [ -f pnpm-lock.yaml ] || [ -f package.json ]; then
    vol_args+=(-v "${proj}-nvm:/home/claude/.nvm")
    vol_args+=(-v "${proj}-pnpm-store:/home/claude/.pnpm-store")
    for pkg in $(find . -name "package.json" -not -path "*/node_modules/*" -exec dirname {} \;); do
      local rel="${pkg#./}"
      if [ "$rel" = "." ] || [ -z "$rel" ]; then
        vol_args+=(-v "${proj}-nm-root:/workspace/node_modules")
      else
        vol_args+=(-v "${proj}-nm-${rel//\//-}:/workspace/${rel}/node_modules")
      fi
    done
  fi

  docker run -it --rm \
    -v "$HOME/.claude:/home/claude/.claude" \
    -v "$HOME/.claude.json:/home/claude/.claude.json" \
    -v "$(pwd):/workspace" \
    "${vol_args[@]}" \
    ${ANTHROPIC_API_KEY:+-e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY"} \
    --network host \
    $tag \
    claude $extra_flags
}
