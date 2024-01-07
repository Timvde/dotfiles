-- Grep in a subdirectory
vim.api.nvim_create_user_command('Rg', function(opts) require("telescope.builtin").live_grep({ cwd = opts.args }) end, { nargs = 1 })

-- Spellcheck in commit messages
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.opt_local.spelllang = "en"
        vim.opt_local.spell = true
    end
})
