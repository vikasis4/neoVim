local opt = vim.opt

-----------------------------------------------------------
-- General
-----------------------------------------------------------

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300

-----------------------------------------------------------
-- UI
-----------------------------------------------------------

opt.number = true
opt.relativenumber = true

opt.cursorline = true

opt.signcolumn = "yes"

opt.termguicolors = true

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.wrap = false

-----------------------------------------------------------
-- Tabs & Indentation
-----------------------------------------------------------

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.smartindent = true

-----------------------------------------------------------
-- Searching
-----------------------------------------------------------

opt.ignorecase = true
opt.smartcase = true

opt.incsearch = true
opt.hlsearch = true

-----------------------------------------------------------
-- Splits
-----------------------------------------------------------

opt.splitbelow = true
opt.splitright = true

-----------------------------------------------------------
-- Better completion
-----------------------------------------------------------

opt.completeopt = {
    "menu",
    "menuone",
    "noselect",
}

-----------------------------------------------------------
-- Numbers
-----------------------------------------------------------

opt.numberwidth = 4

-----------------------------------------------------------
-- True color
-----------------------------------------------------------

opt.termguicolors = true

-----------------------------------------------------------
-- Undo
-----------------------------------------------------------

opt.undolevels = 10000
