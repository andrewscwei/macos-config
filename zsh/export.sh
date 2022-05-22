#!/bin/bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

source "${CWD}/../scripts/init.sh"

function main() {
  export_file ".zshrc" $HOME $CWD/files
}

main
