#!/bin/bash

# Exit if any of the intermediate steps fail.
set -e
shopt -s dotglob

# Colors.
COLOR_PREFIX="\x1b["
COLOR_RESET=$COLOR_PREFIX"0m"
COLOR_BLACK=$COLOR_PREFIX"0;30m"
COLOR_RED=$COLOR_PREFIX"0;31m"
COLOR_GREEN=$COLOR_PREFIX"0;32m"
COLOR_YELLOW=$COLOR_PREFIX"0;33m"
COLOR_BLUE=$COLOR_PREFIX"0;34m"
COLOR_PURPLE=$COLOR_PREFIX"0;35m"
COLOR_CYAN=$COLOR_PREFIX"0;36m"
COLOR_LIGHT_GRAY=$COLOR_PREFIX"0;37m"

# Asserts that a command exists, otherwise exits with code 1.
#
# @param $1 The command name.
function assert_command() {
  if ! type "$1" > /dev/null 2>&1; then
    echo -e "${COLOR_RED}Asserting command exists... ERR: You need ${COLOR_CYAN}$1${COLOR_RED} to run the script${COLOR_RESET}"
    exit 1
  fi
}

# Asserts that a directory exists, otherwise exits with code 1.
#
# @param $1 - The directory path.
function assert_dir() {
  if [ -z "$1" ]; then
    echo -e "${COLOR_RED}Asserting directory exists... ERR: You must provide a directory name${COLOR_RESET}"
    exit 1
  fi

  if [ ! -d "$1" ]; then
    echo -e >&2 "${COLOR_RED}Asserting directory exists... ERR: Directory ${COLOR_CYAN}$1${COLOR_RED} not found${COLOR_RESET}"
    exit 1
  fi
}

# Ensures that a directory exists, if not creates it.
#
# @param $1 The directory to ensure the existence of.
function ensure_dir() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
}

# Exports a file to a target path.
#
# @param $1 The file name.
# @param $2 The directory of the file.
# @param $3 The destination directory to export the file to.
function export_file() {
  local file_name=$1
  local from_dir=$2
  local to_dir=$3

  ensure_dir "${to_dir}"
  cp -rf "${from_dir}/${file_name}" "${to_dir}/${file_name}"

  echo -e "Exporting ${COLOR_CYAN}${file_name}${COLOR_RESET}... OK"
}

# Copies all files from a directory to another directory. The destination
# directory will be overwritten.
#
# @param $1 The source directory to copy files from.
# @param $2 The destination directory to copy files to.
function export_dir() {
  local from_dir=$1
  local to_dir=$2

  if [ -z "$(ls -A ${from_dir})" ]; then
    echo -e "${COLOR_YELLOW}Exporting directory ${COLOR_CYAN}${from_dir}${COLOR_YELLOW}... SKIP: No files to export${COLOR_RESET}"
    return
  fi

  rm -rf "${to_dir}"
  ensure_dir "${to_dir}"

  for file in "${from_dir}"/*; do
    local file_name=${file##*/}
    export_file "${file_name}" "${from_dir}" "${to_dir}"
  done
}

# Downloads a file remotely to a target path.
#
# @param $1 - The file name.
# @param $2 - The URL to the directory of the remote file.
# @param $3 - The destination directory to download the file to.
function install_remote_file() {
  assert_command "curl"

  local file_name=$1
  local remote_dir=$2
  local to_dir=$3

  assert_dir "${to_dir}"

  echo -e "Installing ${COLOR_CYAN}${file_name}${COLOR_RESET}..."

  curl --compressed -q -s "${remote_dir}/${file_name}" -o "${to_dir}/${file_name}" || {
    echo -e "${COLOR_RED}Installing ${COLOR_CYAN}${file_name}${COLOR_RED}... ERR${COLOR_RESET}"
    return 1
  }

  echo -e "${COLOR_GREEN}Installing ${COLOR_CYAN}$file_name${COLOR_GREEN}... OK${COLOR_RESET}"
}

# Downloads a directory remotely to a target path.
#
# @param $1 The URL to the remote directory to download from.
# @param $2 The destination directory to download to.
# @param $3 The local equivalent directory of the remote directory (to use as a
#           reference for scanning files in the directory).)
function install_remote_dir() {
  local remote_dir=$1
  local to_dir=$2
  local ref_dir=$3

  assert_command "curl"
  assert_dir "${ref_dir}"
  assert_dir "${to_dir}"

  for file in "${ref_dir}"/*; do
    local file_name=${file##*/}
    install_remote_file "${file_name}" "${remote_dir}" "${to_dir}"
  done
}
