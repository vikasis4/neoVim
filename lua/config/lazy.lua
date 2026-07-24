local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.notify("lazy.nvim not found!", vim.log.levels.ERROR)
    return
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },

    checker = {
        enabled = true,
    },

    change_detection = {
        notify = false,
    },
})
