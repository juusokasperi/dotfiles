#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Linking ~/.tmux.conf -> $DOTFILES_DIR/.tmux.conf"
ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf

echo "Bye."
