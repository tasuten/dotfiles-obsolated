#!/bin/bash

# when any command returns non-0, exit this script
set -e

source "$(cd $(dirname $0) && pwd)"/configs.sh

die() {
  echo "$@" >&2
  exit 1
}


unset -f die
# unset -v var
