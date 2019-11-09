#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"


# Install apt packages

sudo apt update
package_list="$DIR/package-list"
while IFS= read -r package
do
    sudo apt install -y $package
done < "$package_list"


# Install snap packages

package_list="$DIR/snap-list"
while IFS= read -r package
do
    sudo snap install -y $package
done < "$package_list"


# Install apps directly

for entry in "$DIR/direct-install"/*
do
    $entry
done
