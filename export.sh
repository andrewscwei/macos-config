#!/bin/bash

COLOR_PREFIX="\x1b["; COLOR_RESET=$COLOR_PREFIX"0m"; COLOR_BLACK=$COLOR_PREFIX"0;30m"; COLOR_RED=$COLOR_PREFIX"0;31m"; COLOR_GREEN=$COLOR_PREFIX"0;32m"; COLOR_ORANGE=$COLOR_PREFIX"0;33m"; COLOR_BLUE=$COLOR_PREFIX"0;34m"; COLOR_PURPLE=$COLOR_PREFIX"0;35m"; COLOR_CYAN=$COLOR_PREFIX"0;36m"; COLOR_LIGHT_GRAY=$COLOR_PREFIX"0;37m"

echo -e "${COLOR_PURPLE}Exporting dot files...${COLOR_RESET}"
cd dotfiles
./export.sh
cd ..
echo -e "${COLOR_PURPLE}Exporting dot files... ${COLOR_GREEN}OK${COLOR_RESET}"

echo -e "${COLOR_PURPLE}Exporting app configs...${COLOR_RESET}"
cd apps
./export.sh
cd ..
echo -e "${COLOR_PURPLE}Exporting app configs... ${COLOR_GREEN}OK${COLOR_RESET}"

echo -e "${COLOR_PURPLE}Exporting VSCode config...${COLOR_RESET}"
cd vscode
./export.sh
git add -A && git commit -m "Update config" && git push
cd ..
echo -e "${COLOR_PURPLE}Exporting VSCode config... ${COLOR_GREEN}OK${COLOR_RESET}"

echo

echo -e "${COLOR_PURPLE}Exporting Xcode config...${COLOR_RESET}"
cd xcode
./export.sh
git add -A && git commit -m "Update config" && git push
cd ..
echo -e "${COLOR_PURPLE}Exporting Xcode config... ${COLOR_GREEN}OK${COLOR_RESET}"

echo

echo -e "${COLOR_PURPLE}Exporting Homebrew config...${COLOR_RESET}"
cd homebrew
./export.sh
git add -A && git commit -m "Update config" && git push
cd ..
echo -e "${COLOR_PURPLE}Exporting Homebrew config... ${COLOR_GREEN}OK${COLOR_RESET}"

echo

echo -e "${COLOR_PURPLE}Updating workspace...${COLOR_RESET}"
git add -A && git commit -m "Update config" && git push
echo -e "${COLOR_PURPLE}Updating workspace... ${COLOR_GREEN}OK${COLOR_RESET}"
