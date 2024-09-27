return {
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{
				"<leader>xx",
				"<CMD>Trouble diagnostics jump focus=false<CR>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xs",
				"<CMD>Trouble symbols jump focus=true win.size=0.5<CR>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xc",
				"<CMD>Trouble close<CR>",
				desc = "Close (Trouble)",
			},
		},
		config = function()
			require("trouble").setup()
			-- Disable inline error text
			-- vim.diagnostic.config({virtual_text=false})
		end,
	},
}
