return {
	{ "eandrju/cellular-automaton.nvim" },
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	},
	{ "uga-rosa/ccc.nvim" },
}
