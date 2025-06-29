#!/bin/bash

# Test script for dotfiles setup on macOS
set -e

echo "🍎 Testing dotfiles setup on macOS..."

# Create temporary test directory
TEST_DIR="/tmp/dotfiles-test-$(date +%s)"
mkdir -p "$TEST_DIR"
echo "📂 Created test directory: $TEST_DIR"

# Set fake HOME for testing
export ORIGINAL_HOME="$HOME"
export HOME="$TEST_DIR/fake-home"
mkdir -p "$HOME"

# Debug: Show environment
echo "🔍 Test environment:"
echo "  HOME: $HOME"
echo "  TEST_DIR: $TEST_DIR"

# Clone current dotfiles to test directory
echo "📦 Copying dotfiles to test environment..."
cp -r "$(dirname "$0")/.." "$HOME/.dotfiles"

# Run setup script
echo "🔧 Running setup script..."
cd "$HOME/.dotfiles"
./script/setup.sh

echo "--- Checking symlinks ---"
if [ -d "$HOME/.config" ]; then
    echo "✅ .config directory exists"
    ls -la "$HOME/.config/" || echo "Empty .config directory"
else
    echo "❌ No .config directory found"
    echo "Expected location: $HOME/.config"
fi

echo "--- Home directory symlinks ---"
ls -la "$HOME/" | grep '^l' || echo "No symlinks in home"

echo "--- Checking XDG directories ---"
ls -la "$HOME/.local/share/" 2>/dev/null || echo "No .local/share directory"
ls -la "$HOME/.cache/" 2>/dev/null || echo "No .cache directory"
ls -la "$HOME/.local/state/" 2>/dev/null || echo "No .local/state directory"

echo "--- Checking dotfiles ---"
for dotfile in .profile .zshenv .editorconfig .gitattributes; do
    if [ -L "$HOME/$dotfile" ]; then
        echo "✅ $dotfile is linked"
    else
        echo "❌ $dotfile is missing"
    fi
done

echo "--- Checking macOS-specific files ---"
if [ -L "$HOME/.Brewfile" ]; then
    echo "✅ .Brewfile is linked"
else
    echo "❌ .Brewfile is missing"
fi

if [ -L "$HOME/.config/karabiner" ]; then
    echo "✅ Karabiner config is linked"
else
    echo "❌ Karabiner config is missing"
fi

echo "--- Tree view ---"
if command -v tree &> /dev/null; then
    tree -a -L 2 "$HOME" || ls -la "$HOME"
else
    ls -la "$HOME"
fi

# Cleanup
echo "🧹 Cleaning up test directory..."
export HOME="$ORIGINAL_HOME"
rm -rf "$TEST_DIR"

echo "✅ macOS test completed!"