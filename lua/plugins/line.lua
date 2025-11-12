return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		require("lualine").setup {
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						'filename',
						file_status = true,
						newfile_status = true,
						path = 1,
						shorting_target = 40,
						symbols = {
							modified = '[+]', -- Text to show when the file is modified.
							readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
							unnamed = '[No Name]', -- Text to show for unnamed buffers.
							newfile = '[New]', -- Text to show for newly created file before first write
						}
					}
				},
				lualine_x = {
					{
						'datetime',
						style = '%H:%M:%S',
					}
				},
				lualine_y = { "mode" },
			},
			tabline = {
				lualine_a = { "branch" },
				lualine_b = { "buffers" },
				lualine_c = { "" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "tabs" }
			},
		}
	end
}
