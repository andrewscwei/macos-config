#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

source $CWD/scripts/init.sh

echo -e "Installing Homebrew config..."
cd homebrew
./install.sh
cd ..
echo -e "${COLOR_GREEN}Installing Homebrew config... OK${COLOR_RESET}"

echo

echo -e "Installing ZSH config..."
cd zsh
./install.sh
cd ..
echo -e "${COLOR_GREEN}Installing ZSH config... OK${COLOR_RESET}"

echo

echo -e "Installing app configs..."
cd apps
./install.sh
cd ..
echo -e "${COLOR_GREEN}Installing app configs... OK${COLOR_RESET}"

echo

echo -e "Installing VSCode config..."
cd vscode
./install.sh
cd ..
echo -e "${COLOR_GREEN}Installing VSCode config... OK${COLOR_RESET}"

echo

echo -e "Installing Xcode config..."
cd xcode
./install.sh
cd ..
echo -e "${COLOR_GREEN}Installing Xcode config... OK${COLOR_RESET}"

echo

echo -e "Syncing with remote repo..."
git add -A && git commit -m "Update config" && git push
echo -e "${COLOR_GREEN}Syncing with remote repo... OK${COLOR_RESET}"


} # This ensures the entire script is downloaded
