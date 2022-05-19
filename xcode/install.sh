#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
SRC="https://raw.githubusercontent.com/andrewscwei/macos-config/master/xcode"

source $CWD/../scripts/init.sh

function get_install_dir() {
  printf %s "${INSTALL_PATH:-"$HOME/Library/Developer/Xcode/UserData"}"
}

function install_from_dir() {
  local dir_name=$1
  local remote_dir=$SRC/files/$dir_name
  local to_dir=$(get_install_dir)/$dir_name
  local ref_dir=$CWD/files/$dir_name

  install_remote_dir $remote_dir $to_dir $ref_dir
}

function main() {
  install_from_dir "FontAndColorThemes"
  install_from_dir "KeyBindings"

  echo -e "${COLOR_GREEN}Installation complete, restart Xcode for changes to take effect"
}

main

} # This ensures the entire script is downloaded
