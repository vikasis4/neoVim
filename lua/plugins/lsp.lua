return {
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "saghen/blink.cmp",
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },

        config = function()
            require("lsp")
        end,
    },
}
