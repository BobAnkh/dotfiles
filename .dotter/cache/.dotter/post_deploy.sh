#!/bin/bash
# Post-deploy hook - runs after `dotter deploy`

echo ""
echo "✔ Dotfiles deployed successfully!"
echo ""
echo "Next steps:"
echo "  - If zsh is your default shell, log out and back in to apply changes"
echo "  - If tmux is installed: run 'tmux source ~/.tmux.conf' and press prefix+I to install plugins"
echo "  - If nvim is installed: open nvim and wait for plugins to install automatically"
echo ""
