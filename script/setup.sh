#!/bin/bash

# dotfiles setup script
set -e

DOTFILES_DIR="$HOME/.dotfiles"

# XDG Base Directory Specification
# Always use HOME-relative paths to ensure proper behavior in different environments
XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
XDG_CACHE_HOME="$HOME/.cache"
XDG_STATE_HOME="$HOME/.local/state"

# Allow override from environment if set
if [ -n "${XDG_CONFIG_HOME_OVERRIDE:-}" ]; then
    XDG_CONFIG_HOME="$XDG_CONFIG_HOME_OVERRIDE"
fi
if [ -n "${XDG_DATA_HOME_OVERRIDE:-}" ]; then
    XDG_DATA_HOME="$XDG_DATA_HOME_OVERRIDE"
fi
if [ -n "${XDG_CACHE_HOME_OVERRIDE:-}" ]; then
    XDG_CACHE_HOME="$XDG_CACHE_HOME_OVERRIDE"
fi
if [ -n "${XDG_STATE_HOME_OVERRIDE:-}" ]; then
    XDG_STATE_HOME="$XDG_STATE_HOME_OVERRIDE"
fi

echo "🚀 Setting up dotfiles..."

# Clone dotfiles if not exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "📦 Cloning dotfiles..."
    git clone https://github.com/diohabara/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

echo "🔧 Creating symlinks..."

# Create XDG directories
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_STATE_HOME"

# Link config files to XDG_CONFIG_HOME
for config_dir in .config/*/; do
    if [ -d "$config_dir" ]; then
        config_name=$(basename "$config_dir")
        echo "Linking $XDG_CONFIG_HOME/$config_name"
        ln -sf "$DOTFILES_DIR/$config_dir" "$XDG_CONFIG_HOME/$config_name"
    fi
done

# Link dotfiles to HOME
for dotfile in .*; do
    if [ -f "$dotfile" ] && [[ "$dotfile" != ".config" ]] && [[ "$dotfile" != ".git" ]] && [[ "$dotfile" != ".gitignore" ]]; then
        echo "Linking ~/$dotfile"
        ln -sf "$DOTFILES_DIR/$dotfile" "$HOME/$dotfile"
    fi
done

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Set up GitHub SSH key if needed"
echo "2. Configure macOS settings (Raycast, Japanese Input)"
echo ""
echo "For SSH setup, run:"
echo "  ssh-keygen -t ed25519 -C \"your_email@example.com\""
echo "  gh auth login"
echo "  gh ssh-key add ~/.ssh/id_ed25519.pub"