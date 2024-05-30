return {
	{
		'LunarWatcher/auto-pairs',
		config = function()
			vim.g.AutoPairsPrefix = '<Nop>'
			vim.keymap.set('n', '<leader>ap', ':AutoPairsToggle<CR>')
		end,
	}
}
