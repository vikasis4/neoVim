local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------------------------
-- Highlight text after copying
-----------------------------------------------------------

autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({
            timeout = 200,
        })
    end,
})

-----------------------------------------------------------
-- Return to last cursor position
-----------------------------------------------------------

autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')

        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
