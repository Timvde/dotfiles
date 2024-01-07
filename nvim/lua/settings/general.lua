-- Use space as leader key
vim.g.mapleader = " "

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Search settings
vim.o.hlsearch = true
vim.o.incsearch = true

-- Ignore case when input is all lowercase
vim.o.ignorecase = true
vim.o.smartcase = true

-- Start scrolling before reaching the end of the screen
vim.o.scrolloff = 3
vim.o.sidescrolloff=5

-- Split on the right / below instead of left / above
vim.o.splitbelow = true
vim.o.splitright = true

-- Tab autocompletion for commands
vim.o.wildmode = "longest:full,full"

-- Persistent undo
vim.o.undofile = true

-- Highlight current line
vim.o.cursorline = true

-- Indentation - we have guess-indent.lua, but need a default for new files
vim.o.expandtab = true
vim.o.smartindent = false
vim.o.shiftwidth = 4
vim.o.tabstop = 4
