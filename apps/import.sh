#!/bin/bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
COLOR_PREFIX="\x1b["; COLOR_RESET=$COLOR_PREFIX"0m"; COLOR_BLACK=$COLOR_PREFIX"0;30m"; COLOR_RED=$COLOR_PREFIX"0;31m"; COLOR_GREEN=$COLOR_PREFIX"0;32m"; COLOR_ORANGE=$COLOR_PREFIX"0;33m"; COLOR_BLUE=$COLOR_PREFIX"0;34m"; COLOR_PURPLE=$COLOR_PREFIX"0;35m"; COLOR_CYAN=$COLOR_PREFIX"0;36m"; COLOR_LIGHT_GRAY=$COLOR_PREFIX"0;37m"

function import_file() {
  local file=$1
  local fileName=${file##*/}
  local outDir=$2
  local outFile=${outDir}/$fileName

  mkdir -p ${outDir}
  cp -rf "$file" "$outFile"

  echo ${fileName}
}

function import_files() {
  for file in $1/*; do
    local fileName=${file##*/}
    local outDir=$2
    local outFile=${outDir}/$fileName

    mkdir -; ${outDir}
    cp -rf "$file" "$outFile"
  done

  echo $1
}

function import_divvy() {
  local res=$(import_file "${CWD}/divvy/com.mizage.direct.Divvy.plist" "$HOME/Library/Preferences")
  echo -e "Importing ${COLOR_CYAN}$res${COLOR_RESET}... OK"
}

function export_musescore3() {
  local res=$(import_file "${CWD}/musescore3/shortcuts.xml" "$HOME/Library/Application Support/MuseScore/MuseScore3")
  echo -e "Importing ${COLOR_CYAN}$res${COLOR_RESET}... OK"
}

import_divvy
import_musescore3
