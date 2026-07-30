return {
    "nvim-treesitter/nvim-treesitter",

    branch = "master",

    build = ":TSUpdate",

    lazy = false,

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "python",
                "bash",
                "json",
                "jsonc",
                "yaml",
                "toml",
                "markdown",
                "markdown_inline",
                "vim",
                "vimdoc",

                -- TypeScript / web
                "typescript",
                "tsx",
                "javascript",
                "jsdoc",
                "html",
                "css",
                "scss",
                "graphql",
                "prisma",
            },

            auto_install = true,

            highlight = {
                enable = true,
            },

            indent = {
                enable = true,
            },
        })
    end,
}
