return {
    {
        "saghen/blink.cmp",
        version = "*",

        dependencies = {
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
        },

        opts = {
            keymap = {
                preset = "default",

                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

                ["<CR>"] = { "accept", "fallback" },

                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },

                ghost_text = {
                    enabled = true,
                },
            },

            snippets = {
                preset = "luasnip",
            },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },

            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
        },

        opts_extend = { "sources.default" },
    },
}
