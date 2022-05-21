#!/bin/bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

source $CWD/scripts/init.sh

echo -e "Exporting ZSH config..."
$CWD/zsh/export.sh
echo -e "${COLOR_GREEN}Exporting ZSH config... OK${COLOR_RESET}"

echo

echo -e "Exporting app configs..."
$CWD/apps/export.sh
echo -e "${COLOR_GREEN}Exporting app configs... OK${COLOR_RESET}"

echo

echo -e "Exporting VSCode config..."
$CWD/vscode/export.sh
echo -e "${COLOR_GREEN}Exporting VSCode config... OK${COLOR_RESET}"

echo

echo -e "Exporting Xcode config..."
$CWD/Xcode/export.sh
echo -e "${COLOR_GREEN}Exporting Xcode config... OK${COLOR_RESET}"

echo

echo -e "Exporting Homebrew config..."
$CWD/homebrew/export.sh
echo -e "${COLOR_GREEN}Exporting Homebrew config... OK${COLOR_RESET}"

echo

echo -e "Syncing with remote repo..."
git add -A && git commit -m "Update config" && git push
echo -e "${COLOR_GREEN}Syncing with remote repo... OK${COLOR_RESET}"
