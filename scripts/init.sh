#!/bin/bash

# when any command returns non-0, exit this script
set -e

source "$(cd $(dirname $0) && pwd)"/configs.sh

die() {
  echo "$@" >&2
  exit 1
}

mkdir_p() {
  local target
  target=$1
  if [[ -d $target ]]; then
    mkdir -p "$target"
  fi
}

unset -f die mkdir_p
# unset -v var
