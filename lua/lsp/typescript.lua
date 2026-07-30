local M = {}

-- Shared inlay-hint preferences for both the TS and JS halves of ts_ls.
local inlay_hints = {
    includeInlayParameterNameHints = "literals",
    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayVariableTypeHints = false,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayEnumMemberValueHints = true,
}

function M.setup(capabilities)
    vim.lsp.config("ts_ls", {
        capabilities = capabilities,

        settings = {
            typescript = {
                inlayHints = inlay_hints,

                suggest = {
                    completeFunctionCalls = true,
                },

                updateImportsOnFileMove = {
                    enabled = "always",
                },
            },

            javascript = {
                inlayHints = inlay_hints,

                updateImportsOnFileMove = {
                    enabled = "always",
                },
            },
        },

        on_attach = function(_, bufnr)
            -- ts_ls exposes these as code actions rather than LSP commands, so
            -- they get buffer-local keymaps instead of global ones.
            local function map(lhs, action, desc)
                vim.keymap.set("n", lhs, function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = { action },
                            diagnostics = {},
                        },
                    })
                end, { buffer = bufnr, desc = desc })
            end

            map("<leader>to", "source.organizeImports", "TS: Organize Imports")
            map("<leader>tu", "source.removeUnused", "TS: Remove Unused")
            map("<leader>ta", "source.addMissingImports", "TS: Add Missing Imports")
            map("<leader>tf", "source.fixAll", "TS: Fix All")
        end,
    })

    vim.lsp.enable("ts_ls")
end

return M
