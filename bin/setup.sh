#!/usr/bin/env sh
set -eu
export LC_ALL=C
export LANG=C
IFS="$(printf " \t\nx")"

REPO_URI='https://github.com/diohabara/dotfiles.git'
GHQ_ROOT="${HOME}/repo"
REPO_ROOT="${GHQ_ROOT}/github.com/diohabara/dotfiles"

if ! command -v xcode-select >/dev/null 2>&1; then
	xcode-select --install
fi

if ! command -v git >/dev/null 2>&1; then
	sudo apt update
	sudo apt upgrade -y
	sudo apt install -y git
fi

if [ ! -d "${REPO_ROOT}" ]; then
	command git clone "${REPO_URI}" "${REPO_ROOT}"
else
	cd "${REPO_ROOT}"
	command git pull origin master
fi

cd "${REPO_ROOT}"
./bin/link.sh
./bin/install.sh
