#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/install-kitty.sh"
"$SCRIPT_DIR/install-fonts.sh"

echo ""
echo "======================================="
echo "Bootstrap complete!"
echo "======================================="
echo ""
echo "Next steps:"
echo "1. Launch Kitty"
echo "2. Configure kitty.conf"
echo "3. Start Neovim"
