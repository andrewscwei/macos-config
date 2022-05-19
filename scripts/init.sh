#!/bin/bash

# Exit if any of the intermediate steps fail.
set -e

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
# @param $1 - The command name.
function assert_command() {
  if ! type "$1" > /dev/null 2>&1; then
    echo -e "${COLOR_RED}You need ${COLOR_CYAN}$1${COLOR_RED} to run the script"
    exit 1
  fi
}

# Asserts that a directory exists, otherwise exits with code 1.
#
# @param $1 - The directory path.
function assert_dir() {
  if [ -z "$1" ]; then
    echo -e "${COLOR_RED}You must provide a directory name${COLOR_RESET}"
    exit 1
  fi

  if [ ! -d "$1" ]; then
    echo -e >&2 "${COLOR_RED}Directory ${COLOR_CYAN}$1${COLOR_RED} not found${COLOR_RESET}"
    exit 1
  fi
}

# Ensures that a directory exists, if not creates it.
#
# @param $1 - The directory to ensure the existence of.
function ensure_dir() {
  if [ ! -d "$1" ]; then
    mkdir -p $1
  fi
}

# Copies all files from a directory to another directory. The destination directory will be
# overwritten.
#
# @param $1 - The source directory to copy files from.
# @param $2 - The destination directory to copy files to.
function export_dir() {
  local from_dir=$1
  local to_dir=$2

  if [ -z "$(ls -A $from_dir)" ]; then
    echo -e "${COLOR_CYAN}No files to export${COLOR_RESET}"
    return
  fi

  rm -rf $to_dir
  mkdir -p $to_dir

  for file in $from_dir/*; do
    local f=${file##*/}

    echo -e "Exporting ${COLOR_CYAN}$f${COLOR_RESET}..."

    cp -rf "$file" "$to_dir/$f"
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

  assert_dir $to_dir

  echo -e "Installing $file_name..."

  curl --compressed -q -s "${remote_dir}/${file_name}" -o "${to_dir}/${file_name}" || {
    echo -e "${COLOR_RED}Failed to download from ${COLOR_CYAN}${file_name}${COLOR_RESET}"
    return 1
  }
}

# Downloads a directory remotely to a target path.
#
# @param $1 - The URL to the remote directory to download from.
# @param $2 - The destination directory to download to.
# @param $3 - The local equivalent directory of the remote directory (to use as a reference for
#             scanning files in the directory).)
function install_remote_dir() {
  local remote_dir=$1
  local to_dir=$2
  local ref_dir=$3

  assert_command "curl"
  assert_dir $ref_dir
  assert_dir $to_dir

  for file in "$ref_dir"/*; do
    local file_name=${file##*/}
    install_remote_file $file_name $remote_dir $to_dir
  done
}
