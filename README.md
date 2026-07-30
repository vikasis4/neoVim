# neoVim

A personal Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim), with LSP,
Treesitter, fuzzy finding, completion and formatting wired up out of the box.

Set up for **Python** and **TypeScript/JavaScript**, plus **Copilot-style AI suggestions** served by
a self-hosted [ollama](https://ollama.com) model — so completions stay on hardware you control, with
no subscription and no third-party API.

**Requires Neovim 0.11 or newer** — the LSP setup uses the `vim.lsp.config()` / `vim.lsp.enable()`
API introduced in 0.11.

---

## Table of Contents

- [Install](#install)
- [Repository Layout](#repository-layout)
- [How Startup Works](#how-startup-works)
- [Editor Options](#editor-options)
- [Keymaps](#keymaps)
  - [Files & Search (Telescope)](#files--search-telescope)
  - [File Explorer](#file-explorer)
  - [LSP](#lsp)
  - [Formatting](#formatting)
  - [TypeScript](#typescript)
  - [AI Suggestions](#ai-suggestions)
  - [Git](#git)
  - [Windows & Splits](#windows--splits)
  - [Editing](#editing)
  - [Save & Quit](#save--quit)
  - [Completion (insert mode)](#completion-insert-mode)
- [Plugins](#plugins)
- [Language Servers](#language-servers)
- [Formatters](#formatters)
- [TypeScript Workflow](#typescript-workflow)
- [AI Suggestions](#ai-suggestions-1)
- [Adding Things](#adding-things)
- [Troubleshooting](#troubleshooting)
- [Vim Basics Cheat Sheet](#vim-basics-cheat-sheet)

---

## Install

```bash
git clone <this-repo> ~/.config/nvim
nvim
```

That's it. On first launch, `lua/config/lazy.lua` clones lazy.nvim automatically, then lazy.nvim
installs every plugin and compiles the Treesitter parsers. Give it a minute or two, then restart.

### Terminal & font (optional but recommended)

The statusline, file explorer and completion menu use Nerd Font glyphs. Without a Nerd Font you'll
see tofu boxes (`􀀀`) instead of icons.

```bash
./scripts/bootstrap.sh
```

This installs Kitty (via `apt`) and the JetBrainsMono Nerd Font into `~/.local/share/fonts`. It
needs `sudo` for the Kitty step. Afterwards set this in your `kitty.conf`:

```conf
font_family JetBrainsMono Nerd Font
```

Any terminal works — you only need *some* Nerd Font configured. The scripts are a convenience, not a
requirement.

### External tools

| Tool | Needed for | Install |
| --- | --- | --- |
| `git` | lazy.nvim, plugin updates | usually preinstalled |
| `gcc` / `make` | compiling Treesitter parsers | `sudo apt install build-essential` |
| `ripgrep` | Telescope `live_grep` | `sudo apt install ripgrep` |
| `node` + `npm` | `pyright`, `ts_ls`, `eslint`, `prettier` | [nvm](https://github.com/nvm-sh/nvm) |
| `python3` + `pip` | the `ruff` formatter | usually preinstalled |
| `fd` | faster Telescope `find_files` (optional) | `sudo apt install fd-find` |
| `lazygit` | the `<leader>gg` git UI | see below |
| `ollama` | AI suggestions (local or remote) | see [AI Suggestions](#ai-suggestions-1) |

A `lazygit` binary is committed at the repo root. To put it on your `PATH`:

```bash
install -m 755 ~/.config/nvim/lazygit ~/.local/bin/lazygit
```

---

## Repository Layout

```
init.lua                  entry point — sets leader, then loads config modules
lua/config/
  options.lua             all vim.opt settings
  lazy.lua                bootstraps lazy.nvim, imports lua/plugins/
  keymaps.lua             every custom keymap
  autocmds.lua            autocommands
lua/plugins/              one file per plugin; each returns a lazy.nvim spec
lua/lsp/
  init.lua                builds capabilities, calls each server module
  python.lua              pyright
  lua.lua                 lua_ls
  typescript.lua          ts_ls
scripts/
  bootstrap.sh            runs the two installers below
  install-kitty.sh        apt-installs Kitty
  install-fonts.sh        installs JetBrainsMono Nerd Font
lazy-lock.json            pinned plugin commits — commit this
config_test.sh            diagnostic dump for debugging
```

Everything in `lua/plugins/` is picked up automatically. Drop in a new `.lua` file that returns a
spec table and it gets loaded — no central list to edit.

## How Startup Works

1. `init.lua` sets `<Space>` as both leader keys. **This must happen before lazy.nvim loads**, or
   `<leader>` mappings defined in plugin specs bind to the wrong key.
2. `config.options` applies editor settings.
3. `config.lazy` clones lazy.nvim if missing, prepends it to the runtimepath, and calls
   `require("lazy").setup()` with `{ import = "plugins" }`.
4. `config.keymaps` and `config.autocmds` load last, so they can override anything a plugin set.

## Editor Options

Set in [`lua/config/options.lua`](lua/config/options.lua). The ones that will surprise you:

| Option | Value | Effect |
| --- | --- | --- |
| `clipboard` | `unnamedplus` | yank/paste uses the **system clipboard** — `y` and `p` share with other apps |
| `relativenumber` | `true` | line numbers are relative, so `5j` / `3dd` distances are readable |
| `swapfile` / `backup` | `false` | no `.swp` clutter |
| `undofile` | `true` | undo history persists across restarts |
| `expandtab`, `shiftwidth=4` | 4 spaces | tabs insert 4 spaces |
| `ignorecase` + `smartcase` | `true` | search is case-insensitive until you type a capital |
| `scrolloff` | `8` | keeps 8 lines of context above/below the cursor |
| `wrap` | `false` | long lines run off-screen instead of wrapping |
| `splitbelow` / `splitright` | `true` | new splits open below and to the right |
| `timeoutlen` | `300` | how long a multi-key mapping waits, and when which-key pops up |

## Keymaps

**Leader is `<Space>`.** Press `<Space>` and pause — which-key shows you everything available.

### Files & Search (Telescope)

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files in the project |
| `<leader>fg` | Live grep across the project (needs `ripgrep`) |
| `<leader>fb` | Switch between open buffers |
| `<leader>fh` | Search help tags |
| `<leader>fr` | Recently opened files |

Inside any Telescope window: `<C-n>` / `<C-p>` to move, `<CR>` to open, `<C-x>` horizontal split,
`<C-v>` vertical split, `<C-t>` new tab, `<Esc>` to close.

### File Explorer

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle the Neo-tree sidebar |

Inside the tree: `a` add file (end the name with `/` to make a directory), `d` delete, `r` rename,
`c` copy, `x` cut, `p` paste, `R` refresh, `H` toggle hidden files, `?` show all mappings.

### LSP

Available once a language server attaches to the buffer.

| Key | Action |
| --- | --- |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find all references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol across the project |
| `<leader>ca` | Code action (quick fixes, imports) |
| `<leader>ds` | Document symbols (outline of this file) |
| `<leader>ws` | Workspace symbols (search project-wide) |
| `<leader>D` | List all diagnostics |
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |

`gd`, `gi`, `gr`, `<leader>ds`, `<leader>ws` and `<leader>D` open results in Telescope.

### Formatting

| Key | Action |
| --- | --- |
| `<leader>cf` | Format the current file |

Files are **also formatted automatically on every save** (2s timeout). If no dedicated formatter is
configured for the filetype, conform falls back to the language server's formatter.

### TypeScript

Buffer-local — these only exist while `ts_ls` is attached.

| Key | Action |
| --- | --- |
| `<leader>to` | Organize imports |
| `<leader>tu` | Remove unused imports |
| `<leader>ta` | Add all missing imports |
| `<leader>tf` | Fix everything auto-fixable |

### AI Suggestions

| Key | Mode | Action |
| --- | --- | --- |
| `<A-y>` | insert | Accept the whole suggestion |
| `<A-l>` | insert | Accept one line of it |
| `<A-z>` | insert | Accept N lines (prompts for the number) |
| `<A-]>` | insert | Next suggestion, or request one manually |
| `<A-[>` | insert | Previous suggestion |
| `<A-e>` | insert | Dismiss |

`<A-]>` works in any filetype even when auto-trigger is off. See
[AI Suggestions](#ai-suggestions-1) for the setup.

### Git

| Key | Action |
| --- | --- |
| `<leader>gg` | Open LazyGit |

Inside LazyGit: `<Space>` stage/unstage, `c` commit, `P` push, `p` pull, `Tab` switch panel,
`?` help, `q` quit.

### Windows & Splits

| Key | Action |
| --- | --- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move to the split left / down / up / right |
| `<C-\>` | Jump to the previous split |
| `<C-Up>` / `<C-Down>` | Make the window taller / shorter |
| `<C-Left>` / `<C-Right>` | Make the window narrower / wider |

The `<C-hjkl>` bindings come from vim-tmux-navigator, so the **same keys move seamlessly between
Neovim splits and tmux panes**. This needs the matching config on the tmux side — see the
[plugin README](https://github.com/christoomey/vim-tmux-navigator#tmux).

### Editing

| Key | Mode | Action |
| --- | --- | --- |
| `<Esc>` | normal | Clear search highlighting |
| `<C-a>` | normal | Yank the whole buffer |
| `<` / `>` | visual | Indent left / right and **keep the selection** |
| `J` / `K` | visual | Move the selected lines down / up |

### Save & Quit

| Key | Action |
| --- | --- |
| `<leader>w` | Write |
| `<leader>q` | Quit |
| `<leader>x` | Write and quit |

### Completion (insert mode)

blink.cmp drives completion. Custom bindings from
[`lua/plugins/blink.lua`](lua/plugins/blink.lua):

| Key | Action |
| --- | --- |
| `<Tab>` | Next item, or jump to the next snippet placeholder |
| `<S-Tab>` | Previous item, or previous snippet placeholder |
| `<CR>` | Accept the selected item |
| `<C-Space>` | Show the menu / toggle documentation |

From blink's `default` preset:

| Key | Action |
| --- | --- |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-y>` | Select and accept |
| `<C-e>` | Cancel completion |
| `<C-b>` / `<C-f>` | Scroll the documentation window |
| `<C-k>` | Toggle signature help |

Sources are LSP, filesystem paths, snippets and the current buffer's words. Documentation
auto-opens after 200ms and inline ghost text previews the top match.

## Plugins

Managed by lazy.nvim — run `:Lazy` for the dashboard.

### UI

| Plugin | What it gives you |
| --- | --- |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | The colorscheme (moon variant). Loaded eagerly at priority 1000 so it applies before anything renders. |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline with mode, branch, diagnostics, position. `globalstatus` means one bar for all splits, not one per split. |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Tab-style bar of open buffers along the top, with LSP diagnostic counts per buffer. |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Vertical indent guides. |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Press `<Space>` and pause — a popup lists every mapping under it. The fastest way to explore this config. |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Filetype icons used by the other UI plugins. Needs a Nerd Font. |

### Navigation

| Plugin | What it gives you |
| --- | --- |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, text, buffers, help and LSP results. Prompt sits at the top. |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer sidebar, 35 columns on the left. Shows dotfiles and gitignored files, follows the current file, and closes itself if it's the last window. Lazy-loaded — only starts when you press `<leader>e`. |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | One set of keys for both Neovim splits and tmux panes. |

### Code Intelligence

| Plugin | What it gives you |
| --- | --- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Language server configurations. Ours live in `lua/lsp/`. |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Installs language servers, formatters and linters into `~/.local/share/nvim/mason`. Run `:Mason` for a browsable UI. |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Bridges the two, and auto-installs the servers in `ensure_installed`. |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax-aware highlighting and indentation. `auto_install` grabs a parser the first time you open an unfamiliar filetype. |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Completion engine, with a Rust fuzzy matcher for sorting. |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) + [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet engine and a large ready-made snippet collection. |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save, with per-filetype formatters. |
| [minuet-ai.nvim](https://github.com/milanglacier/minuet-ai.nvim) | Copilot-style inline AI suggestions from a self-hosted ollama model. Lazy-loaded on `InsertEnter`. See [AI Suggestions](#ai-suggestions-1). |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | Opens the LazyGit TUI in a floating window. |

### Useful commands

| Command | Purpose |
| --- | --- |
| `:Lazy` | Plugin dashboard — install, update, clean, profile |
| `:Lazy sync` | Install missing plugins and update the rest |
| `:Lazy profile` | Find what's making startup slow |
| `:Mason` | Browse and install language servers / formatters |
| `:checkhealth` | Diagnose missing dependencies |
| `:TSUpdate` | Update Treesitter parsers |
| `:LspInfo` | Which servers are attached to this buffer |
| `:ConformInfo` | Which formatters apply to this buffer |

## Language Servers

Auto-installed by mason-lspconfig on first launch:

| Server | Language | Notes |
| --- | --- | --- |
| `pyright` | Python | needs `node` |
| `lua_ls` | Lua | configured with `vim` as a known global, so editing this config doesn't produce false warnings |
| `ts_ls` | TypeScript / JavaScript | needs `node`. Inlay hints, auto-import on file move, function-call completion |
| `eslint` | TypeScript / JavaScript | needs `node`. Only attaches when the project has an eslint config, and runs `--fix` on save |

Each has a module in `lua/lsp/` that calls `vim.lsp.config()` then `vim.lsp.enable()`. Completion
capabilities come from blink.cmp via
[`lua/lsp/init.lua`](lua/lsp/init.lua).

## Formatters

Configured in [`lua/plugins/conform.lua`](lua/plugins/conform.lua):

| Filetype | Formatter |
| --- | --- |
| Python | `ruff_organize_imports` then `ruff_format` |
| Lua | `stylua` |
| TS, TSX, JS, JSX | `prettierd`, falling back to `prettier` |
| JSON, JSONC, YAML | `prettierd`, falling back to `prettier` |
| HTML, CSS, SCSS | `prettierd`, falling back to `prettier` |
| GraphQL, Markdown | `prettierd`, falling back to `prettier` |

Anything else falls back to the LSP formatter. Install them all with:

```vim
:MasonInstall stylua ruff prettierd prettier
```

`prettierd` is a daemon, so it avoids paying Node's startup cost on every save — that's why it's
listed first. `prettier` is there as a fallback if the daemon isn't installed. Both respect a
project's `.prettierrc`.

> ESLint and Prettier both run on save and don't conflict: conform runs Prettier for formatting,
> while the eslint LSP applies its own `--fix` for lint rules.

## TypeScript Workflow

Everything below works with zero per-project setup — open a `.ts` file and it's live.

**What you get out of the box**

- Full type checking from `ts_ls`, with errors shown inline as you type
- Auto-imports, and imports rewritten automatically when you move or rename a file
- Inlay hints for parameter names, return types and enum values
- Prettier formatting on save, honouring the project's `.prettierrc`
- ESLint diagnostics and `--fix` on save, when the project has an eslint config
- Treesitter parsers for `typescript`, `tsx`, `javascript`, `jsdoc`, `html`, `css`, `scss`,
  `graphql` and `prisma`

**Per-project tooling.** Both `ts_ls` and `eslint` prefer the versions installed in the project's
`node_modules` over the Mason-installed copies, so a project pinned to an older TypeScript behaves
correctly. Nothing to configure.

**Inlay hints** are configured but not switched on globally. Toggle them per buffer:

```vim
:lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
```

**A note on ESLint.** It attaches only if it finds an `eslint.config.js`, `.eslintrc.json` or
similar. In a project without one, `:LspInfo` will show `ts_ls` alone — that's expected, not a
failure.

**Verify a project is wired up** by opening a TS file and running `:LspInfo` (expect `ts_ls`, plus
`eslint` if configured) and `:ConformInfo` (expect `prettierd`).

## AI Suggestions

Copilot-style inline ghost text, powered by [minuet-ai.nvim](https://github.com/milanglacier/minuet-ai.nvim)
talking to an [ollama](https://ollama.com) server. **Your code never leaves machines you control** —
there's no third-party API and no account.

Configured in [`lua/plugins/ai.lua`](lua/plugins/ai.lua). Keymaps are under
[AI Suggestions](#ai-suggestions) above.

### 1. Set up the ollama server

Ollama can run locally or on another machine on your network.

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama pull qwen2.5-coder:3b-base
```

**Use a `-base` model, not `-instruct`.** Base models are trained for fill-in-the-middle, which is
exactly what inline completion is. Instruct models are tuned for chat and will wrap suggestions in
conversational filler and markdown fences.

Pick the size to match the server's hardware:

| Model | Download | RAM in use | Feel on a modern CPU |
| --- | --- | --- | --- |
| `qwen2.5-coder:1.5b-base` | ~1.0 GB | ~2 GB | Fastest. Use if 3b lags. |
| `qwen2.5-coder:3b-base` | ~1.9 GB | ~2.5 GB | **Recommended.** Best quality-per-latency on CPU. |
| `qwen2.5-coder:7b-base` | ~4.7 GB | ~6.2 GB | Noticeably smarter, but 2–4× slower without a GPU. |

On CPU-only hardware, latency matters far more than model size for inline completion — a suggestion
that arrives after four seconds is one you've already typed past. Start at 3b.

### 2. Expose it on the network (remote server only)

By default ollama listens on loopback and will refuse outside connections. On the **server**:

```bash
sudo systemctl edit ollama
```

Add:

```ini
[Service]
Environment="OLLAMA_HOST=0.0.0.0"
```

Then `sudo systemctl daemon-reload && sudo systemctl restart ollama`. Open the port if a firewall is
running (`sudo ufw allow 11434/tcp`).

> `0.0.0.0` accepts connections from anywhere that can reach the machine, and ollama has **no
> authentication**. Only do this on a network you trust, or restrict the port to your client's IP.

### 3. Point Neovim at it

Set `NVIM_OLLAMA_URL` in your shell profile (`~/.bashrc` or `~/.zshrc`):

```bash
export NVIM_OLLAMA_URL="http://192.168.1.42:11434"
```

The scheme is optional — `192.168.1.42:11434` works too. Unset, it defaults to
`http://127.0.0.1:11434`, so a local ollama needs no configuration at all.

### 4. Check it works

From the **client** machine:

```bash
curl "$NVIM_OLLAMA_URL/api/tags"
```

That should list your models. Then open a Python or TypeScript file, enter insert mode, type a
partial line and pause — grey ghost text appears. `<A-y>` accepts it.

### How it behaves

Suggestions fire automatically in Python, TypeScript, TSX, JavaScript, JSX, Lua, JSON, YAML, shell,
HTML, CSS and SCSS. In any other filetype, `<A-]>` requests one manually.

Requests are throttled to one per 1.5s and debounced 600ms after you stop typing, so ordinary typing
doesn't flood a CPU-bound server. One suggestion is generated per request, capped at 128 tokens, with
1024 characters of surrounding context. Timeout is 8 seconds.

Ghost text stays hidden while the blink.cmp menu is open, so the two don't overlap.

### Tuning

All in [`lua/plugins/ai.lua`](lua/plugins/ai.lua):

| Setting | Turn it down if… | Turn it up if… |
| --- | --- | --- |
| `model` | suggestions are too slow | they're low quality |
| `context_window` | responses lag | suggestions ignore nearby code |
| `throttle` / `debounce` | — | the server can't keep up |
| `request_timeout` | — | you see timeout warnings |
| `max_tokens` | you only want short completions | completions get cut off mid-line |

To stop automatic suggestions but keep manual `<A-]>`, empty the `auto_trigger_ft` list. `:Minuet`
exposes the runtime commands, including toggling virtual text.

## Adding Things

### A plugin

Create a file in `lua/plugins/`:

```lua
-- lua/plugins/comment.lua
return {
    "numToStr/Comment.nvim",
    opts = {},
}
```

Restart, or run `:Lazy sync`.

### A language server

1. Add it to `ensure_installed` in [`lua/plugins/mason.lua`](lua/plugins/mason.lua).
2. Create `lua/lsp/<name>.lua` following the pattern in
   [`lua/lsp/lua.lua`](lua/lsp/lua.lua).
3. Add a `require("lsp.<name>").setup(capabilities)` line to
   [`lua/lsp/init.lua`](lua/lsp/init.lua).

### A formatter

Add the filetype to `formatters_by_ft` in
[`lua/plugins/conform.lua`](lua/plugins/conform.lua), then `:MasonInstall <tool>`.

### A keymap

Add it to [`lua/config/keymaps.lua`](lua/config/keymaps.lua) with a `desc` — the description is what
which-key displays.

> Watch out for prefix collisions. A mapping on `<leader>f` would shadow `<leader>ff`, `<leader>fg`
> and the rest, making every one of them wait out `timeoutlen` first. That's why format is on
> `<leader>cf`.

## Troubleshooting

**Icons show as boxes or question marks.** Your terminal isn't using a Nerd Font. Run
`./scripts/install-fonts.sh` and set `font_family JetBrainsMono Nerd Font`.

**No completion or `gd` does nothing.** Check `:LspInfo` — if no client is attached, the server
probably isn't installed. Open `:Mason` and confirm, or check `:Lazy` for a plugin that failed to
build.

**`<leader>fg` finds nothing.** `ripgrep` is missing: `sudo apt install ripgrep`.

**`<leader>gg` says `LazyGit` is not an editor command.** The `lazygit` binary isn't on your `PATH`.
See [External tools](#external-tools).

**Treesitter errors about a parser.** Run `:TSUpdate`. If compilation fails you're missing a C
compiler: `sudo apt install build-essential`.

**No AI ghost text.** Work through it in order:

1. `echo $NVIM_OLLAMA_URL` — if empty, Neovim is trying localhost.
2. `curl "$NVIM_OLLAMA_URL/api/tags"` — no response means the server is down or not reachable. On a
   remote server check `OLLAMA_HOST=0.0.0.0` is set and the port is open.
3. Confirm the model in that output matches `model` in
   [`lua/plugins/ai.lua`](lua/plugins/ai.lua) exactly, `-base` suffix included.
4. Check the filetype is in `auto_trigger_ft`, or trigger manually with `<A-]>`.
5. `:messages` — minuet reports errors there at `warn` level.

**AI suggestions are too slow, or time out.** Drop to `qwen2.5-coder:1.5b-base`, or lower
`context_window`. Raising `request_timeout` stops the warnings but won't make suggestions usable if
the server is the bottleneck.

**AI suggestions contain prose, markdown fences or explanations.** You're on an `-instruct` model.
Switch to the `-base` variant.

**ESLint doesn't attach to a TypeScript file.** Expected unless the project has an eslint config
(`eslint.config.js`, `.eslintrc.json`, …). `ts_ls` alone in `:LspInfo` is normal.

**Prettier isn't formatting on save.** Check `:ConformInfo` for the buffer. If `prettierd` shows as
unavailable, run `:MasonInstall prettierd`. If a project's `.prettierrc` is malformed, prettier
fails silently and conform falls back to the LSP formatter.

**Everything is broken after an update.** `lazy-lock.json` holds the last known-good commit for
every plugin. Restore it with `git checkout lazy-lock.json` then `:Lazy restore`.

**Start from scratch.** Deleting the plugin data is safe — the next launch reinstalls everything:

```bash
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

**Gathering info for a bug report.** `./config_test.sh` dumps versions, installed plugins and tool
paths.

---

## Vim Basics Cheat Sheet

If you're new to Vim, this is the minimum to be productive. Everything below is stock Vim, not
specific to this config.

### Modes

| Mode | How to enter | Purpose |
| --- | --- | --- |
| Normal | `<Esc>` | Navigate and run commands. Where you start. |
| Insert | `i` | Type text. |
| Visual | `v` | Select text. |
| Command | `:` | Run `:w`, `:q`, and so on. |

When in doubt, press `<Esc>` to get back to normal mode.

### Entering insert mode

| Key | Action |
| --- | --- |
| `i` / `a` | Insert before / after the cursor |
| `I` / `A` | Insert at the start / end of the line |
| `o` / `O` | Open a new line below / above |
| `cw` | Delete to the end of the word and start typing |
| `C` | Delete to the end of the line and start typing |

### Moving

| Key | Action |
| --- | --- |
| `h` `j` `k` `l` | Left, down, up, right |
| `w` / `b` | Forward / back one word |
| `e` | End of the current word |
| `0` / `$` | Start / end of the line |
| `^` | First non-blank character |
| `gg` / `G` | Top / bottom of the file |
| `42G` | Go to line 42 |
| `{` / `}` | Previous / next blank line |
| `<C-d>` / `<C-u>` | Half a page down / up |
| `%` | Jump to the matching bracket |
| `*` | Search for the word under the cursor |
| `f<char>` / `t<char>` | Jump to / just before the next `<char>` on the line |
| `<C-o>` / `<C-i>` | Jump back / forward in the jump list |

With `relativenumber` on, the number next to a line *is* the count to reach it — `7j` goes to the
line showing 7.

### Editing

| Key | Action |
| --- | --- |
| `x` | Delete the character under the cursor |
| `dd` / `3dd` | Delete the line / 3 lines |
| `dw` / `d$` | Delete to the next word / end of line |
| `yy` / `3yy` | Yank (copy) the line / 3 lines |
| `p` / `P` | Paste after / before the cursor |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat the last change |
| `>>` / `<<` | Indent / unindent the line |
| `J` | Join this line with the next |
| `~` | Toggle the case of a character |
| `ciw` | Change the whole word the cursor is in |
| `di(` / `ci"` | Delete / change everything inside `(...)` or `"..."` |

### The grammar

Most commands are `operator` + `motion`:

```
d    w     →  delete word
c    $     →  change to end of line
y    i(    →  yank inside parentheses
d    3j    →  delete this line and 3 below
```

Operators: `d` delete, `c` change, `y` yank, `>` indent, `=` auto-format.
Text objects: `iw` inner word, `aw` a word (with surrounding space), `i(` `i{` `i[` `i"` `i'` inside
a pair, `ip` inner paragraph. Swap `i` for `a` to include the delimiters themselves.

Learning this grammar beats memorising individual keys — the pieces combine.

### Visual mode

| Key | Action |
| --- | --- |
| `v` | Character-wise selection |
| `V` | Line-wise selection |
| `<C-v>` | Block (column) selection |
| `viw` | Select the current word |
| `ggVG` | Select the entire file |

Then `d` delete, `y` yank, `c` change, `>` indent. In this config `J` / `K` move the selection up and
down.

### Search & replace

| Command | Action |
| --- | --- |
| `/text` | Search forward |
| `?text` | Search backward |
| `n` / `N` | Next / previous match |
| `:%s/old/new/g` | Replace every occurrence in the file |
| `:%s/old/new/gc` | Same, but confirm each one |
| `:s/old/new/g` | Replace on the current line only |

`<Esc>` clears the highlighting afterwards.

### Files, buffers & windows

| Command | Action |
| --- | --- |
| `:w` / `:q` / `:wq` | Write / quit / write and quit |
| `:q!` | Quit and discard changes |
| `:e path/to/file` | Open a file |
| `:bn` / `:bp` | Next / previous buffer |
| `:bd` | Close the current buffer |
| `:sp` / `:vsp` | Horizontal / vertical split |
| `<C-w>q` | Close this split |
| `<C-w>=` | Equalise split sizes |

### Marks & macros

| Key | Action |
| --- | --- |
| `ma` | Set mark `a` here |
| `` `a `` | Jump to mark `a` |
| `qa` … `q` | Record a macro into register `a` |
| `@a` / `10@a` | Play it back once / ten times |

Macros are the big win for repetitive edits: record the change on one line, then replay it across
the rest.

### Getting help

| Command | Action |
| --- | --- |
| `:help <topic>` | Open the docs |
| `:help dd` | Docs for a specific key |
| `<leader>fh` | Fuzzy-search help tags |
| `:Tutor` | The built-in 30-minute interactive tutorial |

If you're starting out, `:Tutor` is genuinely worth the half hour.
