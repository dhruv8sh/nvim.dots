return {
	{ 'MeanderingProgrammer/render-markdown.nvim' },
	{
		"oskarrrrrrr/symbols.nvim",
		config = function()
			local r = require("symbols.recipes")
			require("symbols").setup(
				r.DefaultFilters,
				r.AsciiSymbols
			)
		end
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				providers = { "lsp", "treesitter", "regex" },
			})
		end,
	},
}
