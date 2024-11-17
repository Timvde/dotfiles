return {
    {
        "tpope/vim-fugitive",
        cmd = { "Git" },
        keys = {
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    }
}
