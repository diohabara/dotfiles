#!/usr/bin/env bash
# Doc: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME}:${HOME}/.config"

export LANG="C.UTF-8"

# Nix
if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
# Doc: https://github.com/NixOS/nix/issues/3616#issuecomment-662858874
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
# Doc: https://nix-community.github.io/home-manager/index.html#sec-install-standalone
export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

# Vivado
if [ "${OSTYPE}" = "linux-gnu" ]; then
  # Doc: https://danielmangum.com/posts/vivado-2020-x-ubuntu-20-04/
  VIVADO_PATH="/tools/Xilinx/Vivado/2020.3/bin"
  if [ -d "${VIVADO_PATH}" ]; then
    export PATH="${PATH}:${VIVADO_PATH}"
  fi
fi

# LaTeX
export PATH="${PATH}:/usr/local/texlive/2020/bin/x86_64-darwin/"
export PATH="${PATH}:/Library/TeX/texbin/"

# npm
# Doc: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
export NPM_CONFIG_PREFIX=~/.npm-global

# Python
export PATH="${PATH}:${HOME}/.poetry/bin"
