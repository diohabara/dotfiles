#!/usr/bin/env sh
# XDG Base Directory Specification
XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.share"
export CASK_ROOM="/usr/local/Caskroom/"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# for brew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Autocompletion
autoload -Uz compinit
compinit -u
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
eval "$(gh completion -s zsh)"

# divided files
# shellcheck source=/dev/null
. "${XDG_CONFIG_HOME}/zsh/.alias"

# Shell prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG="${HOME}/.config/starship.toml"

# set color config
export TERM=xterm-color

# PATH
export PATH="${PATH}:/usr/local/bin"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:/usr/local/opt/binutils/bin"

## Rust
export PATH="${PATH}:${HOME}/.cargo/bin"
export PKG_CONFIG_PATH="${HOME}/bin/convert"

## LaTeX
export PATH="${PATH}:/usr/local/texlive/2020/bin/x86_64-darwin/"
export PATH="${PATH}:/Library/TeX/texbin/"

# fzf
# Doc: https://nixos.wiki/wiki/Fzf
# shllcheck disable=SC3054
if [ -n "$(which fzf-share)" ]; then
  # shellcheck disable=SC1091
  . "$(fzf-share)/key-bindings.zsh"
  # shellcheck disable=SC1091
  . "$(fzf-share)/completion.zsh"
fi

# zplug
# shellcheck source=/dev/null
. "${HOME}/.zplug/init.zsh"
zplug "sobolevn/wakatime-zsh-plugin", from:github
zplug load

# for direnv
eval "$(direnv hook zsh)"

# enable comments
setopt interactivecomments

# default editor
export EDITOR=vim
bindkey -e

# Doc: https://nixos.wiki/wiki/Locales
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# Doc: https://gist.github.com/meeech/0b97a86f235d10bc4e2a1116eec38e7e
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# linker
FLAG_OPTION="-L$(which lld)"
export LDFLAGS="$FLAG_OPTION"
