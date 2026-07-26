local M = {}

function M.setup(capabilities)
    vim.lsp.config("pyright", {
        capabilities = capabilities,
    })

    vim.lsp.enable("pyright")
end

return M
