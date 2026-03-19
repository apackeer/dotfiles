#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DOTFILES_DIR/scripts/utils.sh"

_info "Dotfiles Installer"
echo ""

# Symlinks
read -p "Create symlinks? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$DOTFILES_DIR/scripts/symlinks.sh" --create
fi

# macOS defaults
if [[ "$(uname)" == "Darwin" ]]; then
    read -p "Apply macOS defaults? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash "$DOTFILES_DIR/scripts/macos.sh"
    fi
fi

# .hushlogin
if [[ ! -f "$HOME/.hushlogin" ]]; then
    read -p "Create ~/.hushlogin to silence login banner? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        touch "$HOME/.hushlogin"
        _success "Created ~/.hushlogin"
    fi
fi

_success "Installation complete!"
