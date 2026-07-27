#!/usr/bin/env bash

set -e

echo "=================================================="
echo "SYSTEM"
echo "=================================================="

date
uname -a

echo
echo "OS"
cat /etc/os-release || true

echo
echo "=================================================="
echo "NEOVIM"
echo "=================================================="

which nvim || true
nvim --version || true

echo
echo "=================================================="
echo "LAZY PLUGINS"
echo "=================================================="

if [ -d "$HOME/.local/share/nvim/lazy" ]; then
    ls "$HOME/.local/share/nvim/lazy"
fi

echo
echo "=================================================="
echo "AVANTE GIT"
echo "=================================================="

if [ -d "$HOME/.local/share/nvim/lazy/avante.nvim" ]; then
    git -C "$HOME/.local/share/nvim/lazy/avante.nvim" rev-parse HEAD
    git -C "$HOME/.local/share/nvim/lazy/avante.nvim" status
fi

echo
echo "=================================================="
echo "INIT.LUA"
echo "=================================================="

cat ~/.config/nvim/init.lua 2>/dev/null || true

echo
echo "=================================================="
echo "AVANTE CONFIG"
echo "=================================================="

cat ~/.config/nvim/lua/plugins/avante.lua 2>/dev/null || true

echo
echo "=================================================="
echo "OLLAMA"
echo "=================================================="

which ollama || true
ollama --version || true
ollama list || true
ollama ps || true

echo
echo "=================================================="
echo "OLLAMA API TAGS"
echo "=================================================="

curl -s http://127.0.0.1:11434/api/tags || true

echo
echo
echo "=================================================="
echo "OLLAMA CHAT TEST"
echo "=================================================="

curl -s http://127.0.0.1:11434/api/chat \
-H "Content-Type: application/json" \
-d '{
  "model":"qwen2.5-coder:7b",
  "messages":[{"role":"user","content":"hi"}],
  "stream":false
}' || true

echo
echo
echo "=================================================="
echo "CURL"
echo "=================================================="

which curl || true
curl --version || true

echo
echo "=================================================="
echo "MAKE"
echo "=================================================="

which make || true
make --version || true

echo
echo "=================================================="
echo "NODE"
echo "=================================================="

which node || true
node --version || true

echo
echo "=================================================="
echo "NPM"
echo "=================================================="

which npm || true
npm --version || true

echo
echo "=================================================="
echo "RIPGREP"
echo "=================================================="

which rg || true
rg --version || true

echo
echo "=================================================="
echo "TMUX"
echo "=================================================="

tmux ls 2>/dev/null || true

echo
echo "=================================================="
echo "PROCESSES"
echo "=================================================="

ps -ef | grep -E "ollama|nvim|tmux" | grep -v grep || true

echo
echo "=================================================="
echo "AVANTE PROVIDER"
echo "=================================================="

sed -n '1,220p' ~/.local/share/nvim/lazy/avante.nvim/lua/avante/providers/ollama.lua 2>/dev/null || true

echo
echo "=================================================="
echo "AVANTE CONFIG DEFAULT"
echo "=================================================="

grep -n "ollama" ~/.local/share/nvim/lazy/avante.nvim/lua/avante/config.lua || true

echo
echo "=================================================="
echo "TREE"
echo "=================================================="

find ~/.config/nvim -maxdepth 3 -type f | sort

echo
echo "=================================================="
echo "DONE"
echo "=================================================="
