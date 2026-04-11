#!/bin/bash

echo "Linking ~/.tmux.conf -> $DOTFILES_DIR/.tmux.conf"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
echo "Bye."
