return {
    "yetone/avante.nvim",
    lazy = false,
    version = false,
    build = "make",

    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },

    opts = {
        provider = "ollama",

        providers = {
            ollama = {
                endpoint = "http://127.0.0.1:11434",
                model = "qwen2.5-coder:7b",

            },
        },
    },
}
