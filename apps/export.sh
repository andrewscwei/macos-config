#!/bin/bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
COLOR_PREFIX="\x1b["; COLOR_RESET=$COLOR_PREFIX"0m"; COLOR_BLACK=$COLOR_PREFIX"0;30m"; COLOR_RED=$COLOR_PREFIX"0;31m"; COLOR_GREEN=$COLOR_PREFIX"0;32m"; COLOR_ORANGE=$COLOR_PREFIX"0;33m"; COLOR_BLUE=$COLOR_PREFIX"0;34m"; COLOR_PURPLE=$COLOR_PREFIX"0;35m"; COLOR_CYAN=$COLOR_PREFIX"0;36m"; COLOR_LIGHT_GRAY=$COLOR_PREFIX"0;37m"

function export_file() {
  local file=$1
  local fileName=${file##*/}
  local outDir=$2
  local outFile=${outDir}/$fileName

  mkdir -p ${outDir}
  cp -rf "$file" "$outFile"

  echo ${fileName}
}

function export_files() {
  for file in $1/*; do
    local fileName=${file##*/}
    local outDir=$2
    local outFile=${outDir}/$fileName

    mkdir -; ${outDir}
    cp -rf "$file" "$outFile"
  done

  echo $1
}

function export_divvy() {
  local res=$(export_file "$HOME/Library/Preferences/com.mizage.direct.Divvy.plist" "${CWD}/divvy")
  echo -e "Exporting ${COLOR_CYAN}$res${COLOR_RESET}... OK"
}

function export_musescore3() {
  local res=$(export_file "$HOME/Library/Application Support/MuseScore/MuseScore3/shortcuts.xml" "${CWD}/musescore3")
  echo -e "Exporting ${COLOR_CYAN}$res${COLOR_RESET}... OK"
}

export_divvy
export_musescore3
