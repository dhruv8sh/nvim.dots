vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.keymaps")
vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h12" }
local bgc = require("config.generated").bg_color
require("cyberdream").setup({
	transparent = false,
	terminal_colors = true,
	colors = { bg = bgc },
})
vim.cmd("colorscheme cyberdream")
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.termguicolors = true

-- Neovide
vim.g.neovide_opacity = 0.8
vim.g.neovide_normal_opacity = 0.8
vim.g.neovide_padding_top = 7
vim.g.neovide_padding_bottom = 7
vim.g.neovide_padding_right = 7
vim.g.neovide_padding_left = 7
