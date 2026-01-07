#!/bin/bash

# dotfiles setup script
set -e

# Parse arguments
DRY_RUN=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run|-n)
            DRY_RUN=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--dry-run|-n]"
            exit 1
            ;;
    esac
done

DOTFILES_DIR="$HOME/.dotfiles"

# XDG Base Directory
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

if [ "$DRY_RUN" = true ]; then
    echo "[DRY RUN] Setting up dotfiles..."
else
    echo "Setting up dotfiles..."
fi

# Clone dotfiles if not exists
if [ ! -d "$DOTFILES_DIR" ]; then
    if [ "$DRY_RUN" = true ]; then
        echo "[DRY RUN] Would clone dotfiles to: $DOTFILES_DIR"
    else
        echo "Cloning dotfiles..."
        git clone https://github.com/diohabara/dotfiles.git "$DOTFILES_DIR"
    fi
fi

if [ "$DRY_RUN" = true ] && [ ! -d "$DOTFILES_DIR" ]; then
    echo "[DRY RUN] Would cd to: $DOTFILES_DIR"
    DOTFILES_DIR="$(pwd)"
fi

if [ -d "$DOTFILES_DIR" ]; then
    cd "$DOTFILES_DIR" || exit 1
else
    echo "Error: DOTFILES_DIR ($DOTFILES_DIR) does not exist"
    exit 1
fi

if [ "$DRY_RUN" = true ]; then
    echo "[DRY RUN] Creating symlinks..."
else
    echo "Creating symlinks..."
fi

# Create XDG directories
if [ "$DRY_RUN" = true ]; then
    echo "[DRY RUN] Would create directories:"
    echo "  - $XDG_CONFIG_HOME"
    echo "  - $XDG_DATA_HOME"
    echo "  - $XDG_CACHE_HOME"
    echo "  - $XDG_STATE_HOME"
else
    mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_STATE_HOME" || {
        echo "Error: Failed to create XDG directories"
        exit 1
    }
fi

# Use stow for symlink management if available
if command -v stow >/dev/null 2>&1; then
    if [ "$DRY_RUN" = true ]; then
        echo "[DRY RUN] Would use stow for symlink management..."
        echo "[DRY RUN] Would run: stow -d \"$DOTFILES_DIR\" -t \"$XDG_CONFIG_HOME\" -S .config"
        if [ -d "$DOTFILES_DIR/.config" ]; then
            # stow handles subdirectories
            find "$DOTFILES_DIR/.config" -maxdepth 1 -type d ! -path "$DOTFILES_DIR/.config" | while read -r dir; do
                dirname=$(basename "$dir")
                echo "[DRY RUN] Would create symlink: $XDG_CONFIG_HOME/$dirname -> $dir"
            done
            # files need to be linked manually
            find "$DOTFILES_DIR/.config" -maxdepth 1 -type f | while read -r file; do
                filename=$(basename "$file")
                echo "[DRY RUN] Would create symlink: $XDG_CONFIG_HOME/$filename -> $file"
            done
        fi
        if [ -d "$DOTFILES_DIR" ]; then
            for dotfile in "$DOTFILES_DIR"/.*; do
                if [ -f "$dotfile" ]; then
                    filename=$(basename "$dotfile")
                    if [ "$filename" != ".git" ] && [ "$filename" != ".gitignore" ]; then
                        echo "[DRY RUN] Would create symlink: $HOME/$filename -> $dotfile"
                    fi
                fi
            done
        fi
    else
        echo "Using stow for symlink management..."
        stow -d "$DOTFILES_DIR" -t "$XDG_CONFIG_HOME" -S .config
        # Link files directly in .config (stow only handles subdirectories)
        if [ -d "$DOTFILES_DIR/.config" ]; then
            find "$DOTFILES_DIR/.config" -maxdepth 1 -type f -exec ln -sf {} "$XDG_CONFIG_HOME/" \;
        fi
        find "$DOTFILES_DIR" -maxdepth 1 -name ".*" -type f ! -name ".git*" ! -name ".gitignore" -exec ln -sf {} "$HOME/" \;
    fi
else
    # Fallback to manual symlinks
    if [ "$DRY_RUN" = true ]; then
        echo "[DRY RUN] Would create symlinks manually..."
        if [ -d "$DOTFILES_DIR/.config" ]; then
            find "$DOTFILES_DIR/.config" -maxdepth 1 \( -type d -o -type f \) ! -path "$DOTFILES_DIR/.config" | while read -r item; do
                itemname=$(basename "$item")
                echo "[DRY RUN] Would create symlink: $XDG_CONFIG_HOME/$itemname -> $item"
            done
        fi
        if [ -d "$DOTFILES_DIR" ]; then
            find "$DOTFILES_DIR" -maxdepth 1 -name ".*" -type f ! -name ".git*" ! -name ".editorconfig" | while read -r file; do
                filename=$(basename "$file")
                echo "[DRY RUN] Would create symlink: $HOME/$filename -> $file"
            done
        fi
    else
        if [ -d "$DOTFILES_DIR/.config" ]; then
            find "$DOTFILES_DIR/.config" -maxdepth 1 \( -type d -o -type f \) ! -path "$DOTFILES_DIR/.config" -exec ln -sf {} "$XDG_CONFIG_HOME/" \;
        fi
        find "$DOTFILES_DIR" -maxdepth 1 -name ".*" -type f ! -name ".git*" ! -name ".editorconfig" ! -name ".gitignore" ! -name ".gitattributes" -exec ln -sf {} "$HOME/" \;
        # Link .editorconfig, .gitignore, .gitattributes separately
        [ -f "$DOTFILES_DIR/.editorconfig" ] && ln -sf "$DOTFILES_DIR/.editorconfig" "$HOME/.editorconfig"
        [ -f "$DOTFILES_DIR/.gitignore" ] && ln -sf "$DOTFILES_DIR/.gitignore" "$HOME/.gitignore"
        [ -f "$DOTFILES_DIR/.gitattributes" ] && ln -sf "$DOTFILES_DIR/.gitattributes" "$HOME/.gitattributes"
    fi
fi

if [ "$DRY_RUN" = true ]; then
    echo ""
    echo "[DRY RUN] Setup simulation complete!"
    echo "[DRY RUN] No actual changes were made."
else
    echo "Setup complete!"
    echo ""
    echo "Next steps:"
    echo "1. Run 'gh auth login' for GitHub authentication"
    echo "2. Configure macOS settings (Raycast, Japanese Input)"
fi
echo ""
