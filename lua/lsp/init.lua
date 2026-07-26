local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lsp.python").setup(capabilities)
require("lsp.lua").setup(capabilities)
require("lsp.typescript").setup(capabilities)
