local keymap = vim.keymap
local builtin = require("telescope.builtin")


vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })

vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })

vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })

vim.keymap.set("n", "<C-a>", ":%y")

-----------------------------------------------------------
-- LSP
-----------------------------------------------------------

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })

vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostics" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
-----------------------------------------------------------
-- Leader
-----------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------------------------------------
-- Better window movement
-----------------------------------------------------------

keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-----------------------------------------------------------
-- Resize windows
-----------------------------------------------------------

keymap.set("n", "<C-Up>", ":resize +2<CR>")
keymap.set("n", "<C-Down>", ":resize -2<CR>")
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-----------------------------------------------------------
-- Clear search highlight
-----------------------------------------------------------

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-----------------------------------------------------------
-- Better indenting
-----------------------------------------------------------

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-----------------------------------------------------------
-- Move selected lines
-----------------------------------------------------------

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-----------------------------------------------------------
-- Save
-----------------------------------------------------------

keymap.set("n", "<leader>w", ":w<CR>")

-----------------------------------------------------------
-- Quit
-----------------------------------------------------------

keymap.set("n", "<leader>q", ":q<CR>")

-----------------------------------------------------------
-- Save & Quit
-----------------------------------------------------------

keymap.set("n", "<leader>x", ":x<CR>")
