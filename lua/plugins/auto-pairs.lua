return {
	{
		'LunarWatcher/auto-pairs',
		-- This needs to be non-lazy, as otherwise the toggle functionality breaks
		lazy = false,
		keys = {
			{
				'<leader>ap',
				':AutoPairsToggle<CR>',
				desc = 'Toggle auto pairs'
			}
		}
	}
}
