#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

# Config.
SRC="https://raw.githubusercontent.com/andrewscwei/vscode-config/macos"
COLOR_PREFIX="\x1b["; COLOR_RESET=$COLOR_PREFIX"0m"; COLOR_BLACK=$COLOR_PREFIX"0;30m"; COLOR_RED=$COLOR_PREFIX"0;31m"; COLOR_GREEN=$COLOR_PREFIX"0;32m"; COLOR_ORANGE=$COLOR_PREFIX"0;33m"; COLOR_BLUE=$COLOR_PREFIX"0;34m"; COLOR_PURPLE=$COLOR_PREFIX"0;35m"; COLOR_CYAN=$COLOR_PREFIX"0;36m"; COLOR_LIGHT_GRAY=$COLOR_PREFIX"0;37m"

# Checks if a command is available.
#
# @param $1 Name of the command.
function command_exists() {
  type "$1" > /dev/null 2>&1
}

# Gets the default install path. This can be overridden when calling the
# download script by passing the INSTALL_PATH variable.
function install_dir() {
  printf %s "${INSTALL_PATH:-"$HOME/Library/Application\ Support/Code/User"}"
}

# Installs config from directory.
function install_settings() {
  echo -e "Installing settings.json..."

  curl --compressed -q -s "$SRC/files/settings.json" -o "$(install_dir)/settings.json" || {
    echo -e "${COLOR_RED}Failed to download from ${COLOR_CYAN}$SRC/files/settings.json${COLOR_RESET}"
    return 1
  }

  echo -e "Installing keybindings.json..."

  curl --compressed -q -s "$SRC/files/keybindings.json" -o "$(install_dir)/keybindings.json" || {
    echo -e "${COLOR_RED}Failed to download from ${COLOR_CYAN}$SRC/files/keybindings.json${COLOR_RESET}"
    return 1
  }
}

function install_extensions() {
  curl --compressed -q -s $SRC/files/extensions.list | xargs -L 1 code --install-extension
}

# Main process.
function main() {
  if ! command_exists curl; then
    echo -e "${COLOR_RED}You need ${COLOR_CYAN}curl${COLOR_RED} to run the install script"
    exit 1
  fi

  if ! command_exists code; then
    echo -e "${COLOR_RED}You need the ${COLOR_CYAN}code${COLOR_RED} command to run the install script: open ${COLOR_CYAN}VSCode${COLOR_RESET} > ${COLOR_CYAN}View${COLOR_RESET} > ${COLOR_CYAN}Command Palette...${COLOR_RESET} > ${COLOR_CYAN}Shell Command: Install 'code' command in PATH${COLOR_RESET}"
    exit 1
  fi

  if [ ! -d "$(install_dir)" ]; then
    echo >&2 "${COLOR_RED}Directory ${COLOR_CYAN}$(install_dir)${COLOR_RED} not found, are you sure you have VSCode installed?${COLOR_RESET}"
    exit 1
  fi

  install_settings
  install_extensions

  echo -e "${COLOR_GREEN}Installation complete, restart VSCode for changes to take effect"
}

main

} # This ensures the entire script is downloaded
