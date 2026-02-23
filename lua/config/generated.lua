local M = {}
M.bg_color = "#16130b"
M.line_colors = {
	normal = {
		a = { bg = "#e3c36c", fg = "#3d2f00", gui = 'bold' },
		b = { bg = "#584400", fg = "#ffe08d" },
		c = { bg = "#16130b", fg = "#eae1d4" }
	},
	insert = {
		a = { bg = "#16130b", fg = "#eae1d4", gui = 'bold' },
		b = { bg = "#584400", fg = "#ffe08d" },
		c = { bg = "#16130b", fg = "#eae1d4" }
	},
	visual = {
		a = { bg = "#e3c36c", fg = "#3d2f00", gui = 'bold' },
		b = { bg = "#584400", fg = "#ffe08d" },
		c = { bg = "#16130b", fg = "#eae1d4" }
	},
	replace = {
		a = { bg = "#e3c36c", fg = "#3d2f00", gui = 'bold' },
		b = { bg = "#584400", fg = "#ffe08d" },
		c = { bg = "#16130b", fg = "#eae1d4" }
	},
	command = {
		a = { bg = "#e3c36c", fg = "#3d2f00", gui = 'bold' },
		b = { bg = "#584400", fg = "#ffe08d" },
		c = { bg = "#16130b", fg = "#eae1d4" }
	},
	inactive = {
		a = { bg = "#ffb4ab", fg = "#690005", gui = 'bold' },
		b = { bg = "#584400", fg = "#ffe08d" },
		c = { bg = "#16130b", fg = "#eae1d4" }
	}
}
return M
