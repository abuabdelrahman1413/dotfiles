vim.cmd("set tabstop=8")
vim.cmd("set shiftwidth=8")
vim.cmd("set autoindent")
vim.cmd("set smartindent")
vim.cmd("set cindent")
vim.cmd("set number")
vim.g.mapleader = " "
vim.cmd("syntax enable")
vim.cmd("set list listchars=nbsp:¬,tab:»·,trail:·,extends:>")
vim.cmd("syntax on")
vim.keymap.set("n", "<leader>a", ":Alpha<CR>")
vim.keymap.set("n", "<leader>qs", ":wqa<CR>")
vim.keymap.set("n", "<leader>q", ":wqa<CR>")
vim.o.background = "dark" -- or "light" for light mode
