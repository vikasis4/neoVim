#!/usr/bin/env bash

set -e

FONT_DIR="$HOME/.local/share/fonts"
TMP_DIR="$(mktemp -d)"

echo "Creating font directory..."
mkdir -p "$FONT_DIR"

cd "$TMP_DIR"

echo "Downloading JetBrainsMono Nerd Font..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

echo "Extracting..."
unzip -q JetBrainsMono.zip

echo "Installing fonts..."
cp *.ttf "$FONT_DIR"

echo "Refreshing font cache..."
fc-cache -fv > /dev/null

echo ""
echo "Installed fonts:"
fc-list | grep "JetBrainsMono Nerd Font" || true

echo ""
echo "Done!"
echo ""
echo "IMPORTANT:"
echo "Open Kitty -> Preferences (or kitty.conf)"
echo "Set:"
echo "font_family JetBrainsMono Nerd Font"

rm -rf "$TMP_DIR"
