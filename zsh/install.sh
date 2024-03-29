#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
SRC="https://raw.githubusercontent.com/andrewscwei/macos-config/master/zsh"

source "${CWD}/../scripts/init.sh"

function get_install_dir() {
  echo ${INSTALL_PATH:-$HOME}
}

function main() {
  assert_command "git"

  rm -rf ~/.zsh/zsh-completions && git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
  rm -rf ~/.zsh/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  rm -rf ~/.zsh/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
  rm -rf ~/.zsh/zsh-autocomplete && git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.zsh/zsh-autocomplete

  install_remote_dir "${SRC}/files" "$(get_install_dir)" "${CWD}/files"

  echo -e "${COLOR_GREEN}Installation complete, restart terminal for changes to take effect"
}

main

} # This ensures the entire script is downloaded
