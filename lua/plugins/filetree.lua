return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			disable_netrw = true,
			view = {
				float = {
					enable = true,
					open_win_config = function()
						local screen_w = vim.opt.columns:get()
						local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
						local w = math.floor(screen_w * 0.30)
						local h = math.floor(screen_h * 0.40)
						return {
							border = "rounded",
							relative = "editor",
							row = screen_h - h - 1,
							col = screen_w - w - 2,
							width = w,
							height = h,
						}
					end,
				},
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
		})
	end,
}
