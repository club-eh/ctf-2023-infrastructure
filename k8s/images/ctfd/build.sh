#!/bin/bash

set -e

cd "$(dirname "$(realpath "$0")")"


# clone CTFd from git if missing
if [[ ! -d "ctfd" ]]; then
	git clone -b deploy 'https://git.sb418.net/sudoBash418/ctfd' "ctfd"
fi

# update CTFd repo
git -C ctfd/ pull

# build container image
podman build -t ctf2023_ctfd -f Containerfile .
