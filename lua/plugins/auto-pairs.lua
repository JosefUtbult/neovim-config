return {
	{
		'LunarWatcher/auto-pairs',
		keys = {
			{
				'<leader>ap',
				':AutoPairsToggle<CR>',
				desc = "Toggle auto pairs"
			}
		},
		config = function()
			vim.g.AutoPairsPrefix = '<Nop>'
		end,
	}
}
