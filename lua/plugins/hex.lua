return {
	{
		"RaafatTurki/hex.nvim",
		keys = {
			{
				'<leader>ah',
				function()
					require('hex').toggle()
				end,
				desc = "Toggle HEX view",
				silent = true
			}
		},
		config = function()
			require('hex').setup()
		end
	}
}
