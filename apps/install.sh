#!/usr/bin/env bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)
SRC="https://raw.githubusercontent.com/andrewscwei/macos-config/master/apps"

source $CWD/../scripts/init.sh

install_remote_file "com.mizage.direct.Divvy.plist" "${SRC}/divvy" "${HOME}/Library/Preferences"
install_remote_file "shortcuts.xml" ${SRC}/musescore3 "$HOME/Library/Application Support/MuseScore/MuseScore3"
