#!/bin/bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

source "${CWD}/../scripts/init.sh"

function main() {
  export_file ".gitconfig" "${HOME}" "${CWD}/files"
  export_file ".gitconfig.ghozt" "${HOME}" "${CWD}/files"
  export_file ".gitconfig.sybl" "${HOME}" "${CWD}/files"
  export_file ".gitconfig.verb" "${HOME}" "${CWD}/files"
}

main
