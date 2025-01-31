-- Lualine status bar
return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local lualine = require("lualine")

			lualine.setup({
				options = {
					-- Use icons
					icons_enabled = true,
					theme = "dracula",
				},
				sections = {
					lualine_a = {
						{
							-- Show full filepath on the status line
							"filename",
							path = 1,
						},
					},
				},
			})
		end,
	},
}
