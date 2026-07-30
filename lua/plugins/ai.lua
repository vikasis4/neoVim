-- Copilot-style inline AI suggestions, served by an ollama instance.
--
-- The ollama server can be local or on another machine. Point this config at it
-- with the NVIM_OLLAMA_URL environment variable:
--
--     export NVIM_OLLAMA_URL="http://192.168.1.42:11434"
--
-- Defaults to localhost when unset. See the README for the server-side setup
-- (OLLAMA_HOST must be 0.0.0.0 for a remote box to accept connections).

-- Accepts "host:port", "http://host:port" or a full URL.
local function ollama_endpoint()
    local url = vim.env.NVIM_OLLAMA_URL or "http://127.0.0.1:11434"

    url = url:gsub("/+$", "")

    if not url:match("^https?://") then
        url = "http://" .. url
    end

    return url .. "/v1/completions"
end

return {
    {
        "milanglacier/minuet-ai.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        event = "InsertEnter",

        config = function()
            require("minuet").setup({
                provider = "openai_fim_compatible",

                -- One suggestion at a time; each extra costs a full round trip
                -- to the model.
                n_completions = 1,

                -- Characters of surrounding code sent as context. Larger is
                -- smarter but slower on a CPU-only server.
                context_window = 1024,

                -- Generous, because the request crosses the network to a CPU
                -- box. Raise this if you see timeout warnings.
                request_timeout = 8,

                -- Don't fire on every keystroke; wait for a pause in typing.
                throttle = 1500,
                debounce = 600,

                notify = "warn",

                virtualtext = {
                    -- Filetypes that get automatic ghost-text suggestions.
                    -- Manual trigger (<A-]>) works in any filetype.
                    auto_trigger_ft = {
                        "python",
                        "typescript",
                        "typescriptreact",
                        "javascript",
                        "javascriptreact",
                        "lua",
                        "json",
                        "yaml",
                        "sh",
                        "html",
                        "css",
                        "scss",
                    },

                    keymap = {
                        accept = "<A-y>",
                        accept_line = "<A-l>",
                        accept_n_lines = "<A-z>",
                        prev = "<A-[>",
                        next = "<A-]>",
                        dismiss = "<A-e>",
                    },

                    -- Keep ghost text out of the way while the blink.cmp menu
                    -- is open, so the two don't fight for the same screen space.
                    show_on_completion_menu = false,
                },

                provider_options = {
                    openai_fim_compatible = {
                        -- ollama needs no auth, but minuet requires the *name*
                        -- of an environment variable here. TERM always exists.
                        api_key = "TERM",

                        name = "Ollama",
                        end_point = ollama_endpoint(),

                        -- Use a -base model, not -instruct: base models are
                        -- trained for fill-in-the-middle and won't emit
                        -- conversational filler around the completion.
                        model = "qwen2.5-coder:3b-base",

                        optional = {
                            max_tokens = 128,
                            top_p = 0.9,
                            stop = { "\n\n" },
                        },
                    },
                },
            })
        end,
    },
}
