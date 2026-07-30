local capabilities = require("blink.cmp").get_lsp_capabilities()

require("lsp.python").setup(capabilities)
require("lsp.lua").setup(capabilities)
require("lsp.typescript").setup(capabilities)
require("lsp.eslint").setup(capabilities)
