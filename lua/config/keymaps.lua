local keymap = vim.keymap

vim.keymap.set("i", "<Tab>", function()
    local suggestion = require("supermaven-nvim.completion_preview")

    if suggestion.has_suggestion() then
        suggestion.on_accept_suggestion()
    else
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
            "n",
            false
        )
    end
end, { desc = "Accept Supermaven Suggestion" })

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

local tb = require("telescope.builtin")

vim.keymap.set("n", "gd", tb.lsp_definitions, { desc = "Go to Definition" })

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

vim.keymap.set("n", "gi", tb.lsp_implementations, { desc = "Go to Implementation" })

vim.keymap.set("n", "gr", tb.lsp_references, { desc = "References" })

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

vim.keymap.set("n", "<leader>ds", tb.lsp_document_symbols, { desc = "Document Symbols" })

vim.keymap.set("n", "<leader>ws", tb.lsp_workspace_symbols, { desc = "Workspace Symbols" })

vim.keymap.set("n", "<leader>D", tb.diagnostics, { desc = "Diagnostics" })

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

-----------------------------------------------------------
-- LazyGit
-----------------------------------------------------------

vim.keymap.set(
    "n",
    "<leader>gg",
    "<cmd>LazyGit<CR>",
    { desc = "Open LazyGit" }
)
-----------------------------------------------------------
-- Formatting
-----------------------------------------------------------

vim.keymap.set("n", "<leader>f", function()
    require("conform").format({
        async = true,
        lsp_fallback = true,
    })
end, { desc = "Format File" })
-----------------------------------------------------------
-- Leader
-----------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
