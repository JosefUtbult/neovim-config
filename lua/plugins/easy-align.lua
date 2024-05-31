return {
	{
		"junegunn/vim-easy-align",
		config = function()
			vim.keymap.set('n', 'ga', '<Plug>EasyAlign')
		end,
	}
}
