#!/bin/bash
set -e

# Setup test environment
TEST_DIR="/tmp/dotfiles-test-$(date +%s)"
export ORIGINAL_HOME="$HOME"
# Clear XDG environment variables to use test HOME
unset XDG_CONFIG_HOME
unset XDG_DATA_HOME
unset XDG_CACHE_HOME
unset XDG_STATE_HOME
export HOME="$TEST_DIR/fake-home"
mkdir -p "$HOME"

# Copy and run setup
(cd "$(dirname "$0")"/.. && tar cf - .) | (mkdir -p "$HOME/.dotfiles" && cd "$HOME/.dotfiles" && tar xf -)
cd "$HOME/.dotfiles" && ./script/setup.sh

# Verify installation
fail=0
[ -d "$HOME/.config" ] || { echo "❌ .config missing"; fail=1; }
for cfg in git karabiner tmux zsh; do
    [ -e "$HOME/.config/$cfg" ] || { echo "❌ .config/$cfg missing"; fail=1; }
done
for dot in .zshenv .editorconfig .gitignore .gitattributes .Brewfile; do
    [ -L "$HOME/$dot" ] || { echo "❌ $dot not linked"; fail=1; }
done

# Cleanup
export HOME="$ORIGINAL_HOME"
rm -rf "$TEST_DIR"

[ $fail -eq 0 ] && echo "✅ All tests passed" || exit 1