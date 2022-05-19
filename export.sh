#!/bin/bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

source $CWD/scripts/init.sh

echo -e "Exporting ZSH config..."
cd zsh
./export.sh
cd ..
echo -e "${COLOR_GREEN}Exporting ZSH config... OK${COLOR_RESET}"

echo -e "Exporting app configs..."
cd apps
./export.sh
cd ..
echo -e "${COLOR_GREEN}Exporting app configs... OK${COLOR_RESET}"

echo -e "Exporting VSCode config..."
cd vscode
./export.sh
cd ..
echo -e "${COLOR_GREEN}Exporting VSCode config... OK${COLOR_RESET}"

echo

echo -e "Exporting Xcode config..."
cd xcode
./export.sh
cd ..
echo -e "${COLOR_GREEN}Exporting Xcode config... OK${COLOR_RESET}"

echo

echo -e "Exporting Homebrew config..."
cd homebrew
./export.sh
cd ..
echo -e "${COLOR_GREEN}Exporting Homebrew config... OK${COLOR_RESET}"

echo

echo -e "Syncing with remote repo..."
git add -A && git commit -m "Update config" && git push
echo -e "${COLOR_GREEN}Syncing with remote repo... OK${COLOR_RESET}"
