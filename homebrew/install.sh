#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

source $CWD/../scripts/init.sh

function read_password() {
   echo -e "Enter password for ${COLOR_CYAN}${USER}${COLOR_RESET}: "
   read -s PASSWORD
   echo ""

   if [[ -z "$PASSWORD" ]]; then
      printf '%s\n' "A password is required..."
      read_password
   fi
}

function ensure_brew() {
  if ! type "brew" > /dev/null 2>&1; then
    read_password
    echo $PASSWORD | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # rm -rf $(brew --repo homebrew/core)
    # brew tap homebrew/core
  fi
}

ensure_brew
brew bundle install --file=$CWD/Brewfile

} # This ensures the entire script is downloaded
