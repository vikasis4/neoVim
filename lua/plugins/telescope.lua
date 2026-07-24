return {
    "nvim-telescope/telescope.nvim",

    branch = "0.1.x",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                layout_strategy = "horizontal",

                sorting_strategy = "ascending",

                layout_config = {
                    prompt_position = "top",
                },

                winblend = 0,
            },
        })
    end,
}
