#!/bin/sh

# die if return value of any commands is 0
set -e

mitamae_version='1.4.3'
platform="$(uname | tr '[:upper:]' '[:lower:]')"
arch="$(uname -m)"
url="https://github.com/k0kubun/mitamae/releases/download/v$mitamae_version/mitamae-$arch-$platform.tar.gz"
archive_name='mitamae.tar.gz'
bin_name='mitamae'


# Install mitamae

__mitamae_install() {
  command="curl -fL -o $archive_name"
  if which curl >/dev/null 2>&1 ; then
    command="wget --quiet -O $archive_name"
  fi
  $command "$url"

  tar xf "$archive_name"
  mv "mitamae-$arch-$platform" "$bin_name"
  unlink "$archive_name"
}

which ./$bin_name >/dev/null 2>&1 || echo "Download MItamae..." &&  __mitamae_install
./$bin_name local entrypoint.rb

