return {
	{
		"andrewferrier/wrapping.nvim",
		keys = {
			{
				"<leader>aw",
				"<CMD>ToggleWrapMode<CR>",
				desc = "Toggle WrapMode"
			}
		},
		config = function()
			require("wrapping").setup()
		end
	},
}
