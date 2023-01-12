#!/bin/bash

set -e

cd "$(dirname "$(realpath "$0")")"


# clone CTFd from git if missing
if [[ ! -d "ctfd" ]]; then
	git clone -b deploy 'https://git.sb418.net/sudoBash418/ctfd' "ctfd"
fi

# clone custom CTFd theme from git if missing
if [[ ! -d "ctfd/CTFd/themes/ctfd-theme" ]]; then
	git clone -b hackers-odyssey 'git@github.com:club-eh/ctfd-theme.git' "ctfd-theme"
fi

# update CTFd repo
git -C ctfd/ pull

# update CTFd theme repo
git -C ctfd/CTFd/themes/ctfd-theme pull

# build theme
(
	cd ctfd/CTFd/themes/ctfd-theme
	yarn install
	yarn run build
)

# build container image
podman build -t ctf2023_ctfd -f Containerfile .
