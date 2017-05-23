#!/bin/bash

# when any command returns non-0, exit this script
set -e

source_config() {
  local this_directory
  this_directory=$(cd "$(dirname "$0")" && pwd)
  source "$this_directory/configs.sh"
}

die() {
  echo "$@" >&2
  exit 1
}

mkdir_p() {
  local target
  target=$1
  if [[ ! -d $target ]]; then
    mkdir -p "$target"
  fi
}


source_config

unset -f die mkdir_p
# unset -v var
