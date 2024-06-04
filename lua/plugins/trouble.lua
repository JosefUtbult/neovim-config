return {
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		keys = {
			{
				"<leader>xx",
				"<CMD>Trouble diagnostics jump focus=false<CR>",
				desc = "Diagnostics (Trouble)"
			},
			{
				"<leader>xs",
				"<CMD>Trouble symbols jump focus=false<CR>",
				desc = "Symbols (Trouble)"
			},
			{
				"<leader>xc",
				"<CMD>Trouble close<CR>",
				desc = "Close (Trouble)"
			}
		},
		opts = {
			modes = {
				symbols = {
					preview = {
						type = "split",
						relative = "win",
						position = "right",
						size = 1,
					},
				}
			}
		},
		config = function()
			require('trouble').setup()
			-- Disable inline error text
			-- vim.diagnostic.config({virtual_text=false})
		end,
	}
}
