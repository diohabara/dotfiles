#!/bin/sh

cd "$(dirname "$0")" || exit

sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply -S .
