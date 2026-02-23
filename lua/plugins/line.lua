return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "echasnovski/mini.icons" },
	opts = function()
		local filetype_map = {
			lazy = { name = "lazy.nvim", icon = "💤" },
			minifiles = { name = "minifiles", icon = "🗂️ " },
			snacks_terminal = { name = "terminal", icon = "🐚" },
			mason = { name = "mason", icon = "🔨" },
			snacks_picker_input = { name = "picker", icon = "🔍" },
			["copilot-chat"] = { name = "copilot", icon = "🤖" },
		}
		local theme = require("config.generated").line_colors;

		return {
			options = {
				component_separators = { left = " ", right = " " },
				section_separators = { left = " ", right = " " },
				theme = theme,
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha" } },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						icon = "",
						fmt = function(mode)
							return mode:lower()
						end,
					},
				},
				lualine_b = { { "branch", icon = "" } },
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = "󰝶 ",
						},
					},
					{
						"filename",
						padding = { left = 0, right = 0 },
						fmt = function(name)
							if filetype_map[vim.bo.filetype] then
								return filetype_map[vim.bo.filetype].name
							else
								return name
							end
						end,
					},
				},
				lualine_x = {
					{ "diff" },
				},
				lualine_y = {
					{
						"progress",
					},
				},
				lualine_z = {
					{
						"datetime",
						style = "  %X",
					},
				},
			},
		}
	end,
}
