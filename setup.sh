#!/bin/sh

# die when any commands die with non-zero value
set -e
# Don't allow undefined value
set -u

mitamae_version='v1.4.3'
os=$(uname | tr '[:upper:]' '[:lower:]')
arch=$(uname -m)

url="https://github.com/k0kubun/mitamae/releases/download/$mitamae_version/mitamae-$arch-$os.tar.gz"

bin_name='mitamae'

download() {
  src="$1"
  dst="$2"
  cmd="curl -o $dst -fL# $src"
  if ! which curl >/dev/null 2>&1; then
    cmd="wget -O $dst $src"
  fi
  $cmd
}

if [ ! -f  $bin_name ]; then
  echo "Download MItamae"
  download "$url" mitamae.tar.gz
  tar xf mitamae.tar.gz
  rm mitamae.tar.gz
  mv "mitamae-$arch-$os" mitamae
else
  echo "Already Downloaded MItamae"
fi

./mitamae local -y "nodes/$os.yml" entrypoint.rb


