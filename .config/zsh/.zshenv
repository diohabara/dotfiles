#!/usr/bin/env sh
export LANG=en_US.UTF-8

if [ -d "${HOME}/.bun/bin" ]; then
  case ":${PATH}:" in
    *:"${HOME}/.bun/bin":*) ;;
    *) export PATH="${HOME}/.bun/bin:${PATH}" ;;
  esac
fi
