return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },

    opts = {
        strategies = {
            chat = {
                adapter = "ollama",
            },
            inline = {
                adapter = "ollama",
            },
            agent = {
                adapter = "ollama",
            },
        },

        adapters = {
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = "http://127.0.0.1:11434",
                    },

                    schema = {
                        model = {
                            default = "qwen2.5-coder:7b",
                        },
                    },
                })
            end,
        },
    },

    keys = {
        {
            "<leader>cc",
            "<cmd>CodeCompanionChat Toggle<CR>",
            desc = "AI Chat",
        },

        {
            "<leader>ca",
            "<cmd>CodeCompanionActions<CR>",
            desc = "AI Actions",
        },

        {
            "<leader>ci",
            "<cmd>CodeCompanion<CR>",
            mode = { "n", "v" },
            desc = "Inline AI",
        },
    },
}
