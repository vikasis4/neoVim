return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "pyright",
                "lua_ls",
            },
        },
    },
}
