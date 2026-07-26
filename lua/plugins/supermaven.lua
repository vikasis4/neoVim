return {
    {
        "supermaven-inc/supermaven-nvim",
        event = "InsertEnter",

        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = nil,
                    clear_suggestion = nil,
                    accept_word = nil,
                },

                ignore_filetypes = {
                    gitcommit = true,
                    markdown = false,
                },

                color = {
                    suggestion_color = "#6C7086",
                    cterm = 244,
                },

                log_level = "off",
                disable_inline_completion = false,
                disable_keymaps = true,
            })
        end,
    },
}
