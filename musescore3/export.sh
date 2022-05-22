#!/bin/bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

source $CWD/../scripts/init.sh

export_file "shortcuts.xml" "$HOME/Library/Application Support/MuseScore/MuseScore3" "${CWD}/files"
