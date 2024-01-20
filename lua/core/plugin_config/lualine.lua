-- Lualine status bar
require('lualine').setup {
	options = {
		-- Use icons
		icons_enabled = true,
		-- Use the gruvbox theme
		theme = 'gruvbox',
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
