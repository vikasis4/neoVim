local keymap = vim.keymap

-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })

keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })

keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })

keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })

keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files" })

keymap.set("n", "<C-a>", ":%y<CR>", { desc = "Yank Whole Buffer" })

-----------------------------------------------------------
-- LSP
-----------------------------------------------------------

keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to Definition" })

keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Go to Implementation" })

keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "References" })

keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })

keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document Symbols" })

keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace Symbols" })

keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })

keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })

keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous Diagnostic" })

-----------------------------------------------------------
-- LazyGit
-----------------------------------------------------------

keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-----------------------------------------------------------
-- Formatting
-----------------------------------------------------------

keymap.set("n", "<leader>cf", function()
    require("conform").format({
        async = true,
        lsp_fallback = true,
    })
end, { desc = "Format File" })

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
-- Save / Quit
-----------------------------------------------------------

keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })

keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save & Quit" })
