vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.keymaps")

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.cmd("colorscheme catppuccin-mocha")
