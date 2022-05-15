#!/bin/bash

SRC="$HOME/Library/Developer/Xcode/UserData"
CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
COLOR_PREFIX="\x1b["; COLOR_RESET=$COLOR_PREFIX"0m"; COLOR_BLACK=$COLOR_PREFIX"0;30m"; COLOR_RED=$COLOR_PREFIX"0;31m"; COLOR_GREEN=$COLOR_PREFIX"0;32m"; COLOR_ORANGE=$COLOR_PREFIX"0;33m"; COLOR_BLUE=$COLOR_PREFIX"0;34m"; COLOR_PURPLE=$COLOR_PREFIX"0;35m"; COLOR_CYAN=$COLOR_PREFIX"0;36m"; COLOR_LIGHT_GRAY=$COLOR_PREFIX"0;37m"

function export_themes() {
  local i=${SRC}/FontAndColorThemes
  local o=${CWD}/FontAndColorThemes

  if [ -z "$(ls -A $i)" ]; then
    echo -e "${COLOR_CYAN}No theme files to export${COLOR_RESET}"
    return
  fi

  rm -rf $o
  mkdir -p $o

  for file in $i/*; do
    local f=${file##*/}

    echo -e "Exporting theme ${COLOR_CYAN}$f${COLOR_RESET}..."

    cp -rf "$file" "$o/$f"
  done
}

function export_key_bindings() {
  local i=${SRC}/KeyBindings
  local o=${CWD}/KeyBindings

  if [ -z "$(ls -A $i)" ]; then
    echo -e "${COLOR_CYAN}No key bindings to export${COLOR_RESET}"
    return
  fi

  rm -rf $o
  mkdir -p $o

  for file in $i/*; do
    local f=${file##*/}

    if [ $f == "Default.idekeybindings" ]; then continue; fi

    echo -e "Exporting key binding ${COLOR_CYAN}$f${COLOR_RESET}..."

    cp -rf "$file" "$o/$f"
  done
}

export_themes
export_key_bindings
