#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
SRC="https://raw.githubusercontent.com/andrewscwei/macos-config/master/vscode"

source "${CWD}/../scripts/init.sh"

function get_install_dir() {
  echo ${INSTALL_PATH:-${HOME}/Library/Application Support/Code/User}
}

function install_settings() {
  local install_dir="$(get_install_dir)"

  ensure_dir "${install_dir}"
  install_remote_file "settings.json" "${SRC}/files" "$(get_install_dir)"
  install_remote_file "keybindings.json" "${SRC}/files" "$(get_install_dir)"
}

function install_extensions() {
  assert_command "curl"
  assert_command "code"
  curl --compressed -q -s $SRC/files/extensions.list | xargs -L 1 code --install-extension
}

function main() {
  install_settings
  install_extensions

  echo -e "${COLOR_GREEN}Installation complete, restart VSCode for changes to take effect"
}

main

} # This ensures the entire script is downloaded
