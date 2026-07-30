local M = {}

function M.setup(capabilities)
    vim.lsp.config("eslint", {
        capabilities = capabilities,

        settings = {
            -- Let eslint work in projects that only have a flat config.
            experimental = {
                useFlatConfig = false,
            },

            workingDirectories = {
                mode = "auto",
            },
        },

        on_attach = function(_, bufnr)
            -- Apply eslint's own --fix on save. This runs alongside prettier
            -- (which conform handles), not instead of it.
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "LspEslintFixAll",
            })
        end,
    })

    vim.lsp.enable("eslint")
end

return M
