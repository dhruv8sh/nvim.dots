local M = {}
M.bg_color = "#191113"
M.line_colors = {
	normal = {
		a = { bg = "#ffb1c1", fg = "#551d2c", gui = 'bold' },
		b = { bg = "#713342", fg = "#ffd9df" },
		c = { bg = "#191113", fg = "#efdee0" }
	},
	insert = {
		a = { bg = "#191113", fg = "#efdee0", gui = 'bold' },
		b = { bg = "#713342", fg = "#ffd9df" },
		c = { bg = "#191113", fg = "#efdee0" }
	},
	visual = {
		a = { bg = "#ffb1c1", fg = "#551d2c", gui = 'bold' },
		b = { bg = "#713342", fg = "#ffd9df" },
		c = { bg = "#191113", fg = "#efdee0" }
	},
	replace = {
		a = { bg = "#ffb1c1", fg = "#551d2c", gui = 'bold' },
		b = { bg = "#713342", fg = "#ffd9df" },
		c = { bg = "#191113", fg = "#efdee0" }
	},
	command = {
		a = { bg = "#ffb1c1", fg = "#551d2c", gui = 'bold' },
		b = { bg = "#713342", fg = "#ffd9df" },
		c = { bg = "#191113", fg = "#efdee0" }
	},
	inactive = {
		a = { bg = "#ffb4ab", fg = "#690005", gui = 'bold' },
		b = { bg = "#713342", fg = "#ffd9df" },
		c = { bg = "#191113", fg = "#efdee0" }
	}
}
return M
