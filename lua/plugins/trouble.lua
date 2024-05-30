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
				"<CMD>Trouble symbols toggle focus=true<CR>",
				desc = "Symbols (Trouble)"
			},
			{
				"<leader>xc",
				"<CMD>Trouble close<CR>",
				desc = "Close (Trouble)"
			}
		},
		config = function()
			require('trouble').setup()
			-- Disable inline error text
			vim.diagnostic.config({virtual_text=false})
		end,
	}
}
