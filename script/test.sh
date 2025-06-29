#!/bin/bash

# Test script for dotfiles setup
set -e

echo "🧪 Testing dotfiles setup..."

# Build and run Docker test
echo "📦 Building test Docker image..."
docker build -f Dockerfile.test -t dotfiles-test .

echo "🔧 Running setup test in container..."
docker run --rm dotfiles-test /bin/bash -c "
    echo '--- Checking symlinks ---'
    ls -la ~/.config/ || echo 'No .config directory'
    ls -la ~/ | grep '^l' || echo 'No symlinks in home'
    
    echo '--- Checking XDG directories ---'
    ls -la ~/.local/share/ || echo 'No .local/share directory'
    ls -la ~/.cache/ || echo 'No .cache directory'
    ls -la ~/.local/state/ || echo 'No .local/state directory'
    
    echo '--- Checking dotfiles ---'
    ls -la ~/.profile ~/.zshenv ~/.editorconfig ~/.gitattributes || echo 'Some dotfiles missing'
    
    echo '--- Tree view ---'
    tree -a -L 2 ~ || ls -la ~
"

echo "✅ Test completed!"