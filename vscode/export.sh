#!/bin/bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
FROM_DIR="$HOME/Library/Application Support/Code/User"
TO_DIR="$CWD/files"

source $CWD/../scripts/init.sh

echo -e "Exporting ${COLOR_CYAN}settings.json${COLOR_RESET}..."
cp -rf "${FROM_DIR}/settings.json" "${TO_DIR}/settings.json"

echo -e "Exporting ${COLOR_CYAN}keybindings.json${COLOR_RESET}..."
cp -rf "${FROM_DIR}/keybindings.json" "${TO_DIR}/keybindings.json"

echo -e "Exporting extensions to ${COLOR_CYAN}extensions.list${COLOR_RESET}..."
code --list-extensions > ${TO_DIR}/extensions.list
