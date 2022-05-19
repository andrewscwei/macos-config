#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

# Config.
SRC="https://raw.githubusercontent.com/andrewscwei/macos-config"
COLOR_PREFIX="\x1b["; COLOR_RESET=$COLOR_PREFIX"0m"; COLOR_BLACK=$COLOR_PREFIX"0;30m"; COLOR_RED=$COLOR_PREFIX"0;31m"; COLOR_GREEN=$COLOR_PREFIX"0;32m"; COLOR_ORANGE=$COLOR_PREFIX"0;33m"; COLOR_BLUE=$COLOR_PREFIX"0;34m"; COLOR_PURPLE=$COLOR_PREFIX"0;35m"; COLOR_CYAN=$COLOR_PREFIX"0;36m"; COLOR_LIGHT_GRAY=$COLOR_PREFIX"0;37m"

function read_password() {
   echo -e "Enter password for ${COLOR_CYAN}${USER}${COLOR_RESET}: "
   read -s PASSWORD
   echo ""

   if [[ -z "$PASSWORD" ]]; then
      printf '%s\n' "A password is required..."
      read_password
   fi
}

function main() {
  # Install Homebrew
  echo $PASSWORD | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # rm -rf $(brew --repo homebrew/core)
  # brew tap homebrew/core
}

read_password
main

} # This ensures the entire script is downloaded
