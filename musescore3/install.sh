#!/usr/bin/env bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
SRC="https://raw.githubusercontent.com/andrewscwei/macos-config/master/musescore3"

source $CWD/../scripts/init.sh

install_remote_file "shortcuts.xml" "${SRC}/files" "${HOME}/Library/Application Support/MuseScore/MuseScore3"
