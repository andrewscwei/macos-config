#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

source $CWD/scripts/init.sh

echo -e "Installing Homebrew config..."
$CWD/homebrew/install.sh
echo -e "${COLOR_GREEN}Installing Homebrew config... OK${COLOR_RESET}"

echo

echo -e "Installing ZSH config..."
$CWD/zsh/install.sh
echo -e "${COLOR_GREEN}Installing ZSH config... OK${COLOR_RESET}"

echo

echo -e "Installing app configs..."
$CWD/apps/install.sh
echo -e "${COLOR_GREEN}Installing app configs... OK${COLOR_RESET}"

echo

echo -e "Installing VSCode config..."
$CWD/vscode/install.sh
echo -e "${COLOR_GREEN}Installing VSCode config... OK${COLOR_RESET}"

echo

echo -e "Installing Xcode config..."
$CWD/xcode/install.sh
echo -e "${COLOR_GREEN}Installing Xcode config... OK${COLOR_RESET}"

echo

} # This ensures the entire script is downloaded
