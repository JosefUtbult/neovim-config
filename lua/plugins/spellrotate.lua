-- Keymap spell rotating forward
return {
	{
		'tweekmonster/spellrotate.vim',
		keys = {
			{
				';;',
				'<Plug>(SpellRotateForward)',
				desc = "Spell rotation (normal)"
			},
			{
				';;',
				'<C-O><Plug>(SpellRotateForward)',
				mode = "i",
				desc = "Spell rotation (insert)"
			}
		},
	}
}
