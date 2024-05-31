-- Keymap spell rotating forward
return {
	{
		'tweekmonster/spellrotate.vim',
		config = function()
			vim.keymap.set('n', ';;', '<Plug>(SpellRotateForward)')
			vim.keymap.set('i', ';;', '<C-O><Plug>(SpellRotateForward)')
		end
	}
}
