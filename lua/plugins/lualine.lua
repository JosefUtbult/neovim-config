-- Lualine status bar
return {
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				-- Use icons
				icons_enabled = true,
				theme = 'dracula',
			},
			sections = {
				lualine_a = {
					{
						-- Show full filepath on the status line
						'filename',
						path = 1,
					}
				}
			}
		}
	}
}
