#!/usr/bin/env bash

set -e

echo "Updating package list..."
sudo apt update

echo "Installing Kitty..."
sudo apt install -y kitty

echo ""
echo "Installed version:"
kitty --version
