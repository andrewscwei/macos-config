#!/bin/bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
FROM_DIR="$HOME/Library/Developer/Xcode/UserData"
TO_DIR="$CWD/files"

source "${CWD}/../scripts/init.sh"

function export_themes() {
  export_dir ${FROM_DIR}/FontAndColorThemes ${TO_DIR}/FontAndColorThemes
}

function export_key_bindings() {
  export_dir ${FROM_DIR}/KeyBindings ${TO_DIR}/KeyBindings
  rm -rf ${TO_DIR}/KeyBindings/Default.idekeybindings
  echo -e "${COLOR_YELLOW}Exporting Default.idekeybindings... REVERTED${COLOR_RESET}"
}

export_themes
export_key_bindings
