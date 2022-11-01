#!/usr/bin/env bash
# Bootstrap installs and configures NixOS + Home Manager

sudo cp --force ./configuration.nix /etc/nixos/
sudo nixos-rebuild switch

# Enable and start VSCode server fix
systemctl --user enable auto-fix-vscode-server.service
systemctl --user start auto-fix-vscode-server.service

# Install and configure Home Manager
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
nix-shell '<home-manager>' -A install
sudo cp --force ./home.nix $HOME/.config/nixpkgs/
home-manager switch
