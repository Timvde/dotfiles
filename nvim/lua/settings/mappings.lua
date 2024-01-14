-- Y is equivalent to yy by default, but y$ is more useful and consistent with e.g. D and C
vim.keymap.set("n", "Y", "y$")
-- Don't let x overwrite the default register
vim.keymap.set("n", "x", '"_x')
-- Don't exit visual mode after indent change
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- Toggle spelling
vim.keymap.set("n", "<leader>ss", "<cmd>setlocal spell!<cr>")
-- Exit terminal mode - when attached in neotest
vim.keymap.set("t", "<leader>q", "<C-\\><C-n>")
