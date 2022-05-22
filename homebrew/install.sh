#!/usr/bin/env bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

source "${CWD}/../scripts/init.sh"

function ensure_brew() {
  if ! type "brew" > /dev/null 2>&1; then
    echo -e "Checking if Homebrew needs to be installed... OK: Installing Homebrew now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo -e "${COLOR_GREEN}Checking if Homebrew needs to be installed... OK: Homebrew is installed${COLOR_RESET}"
  fi
}

ensure_brew
brew bundle install --file="${CWD}/Brewfile"
