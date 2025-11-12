vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.keymaps")

vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h14" }

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.cmd("colorscheme neopywal-dark")
require("lualine").setup {
	options = {
		theme = "neopywal",
	}
}

require("neopywal").setup {
	use_palette = "gruvbox-hard",
}


vim.opt.termguicolors = true
