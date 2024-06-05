return {
	{
		'Vonr/align.nvim',
		branch = "v2",
		lazy = true,
		keys = {
			{
				"<leader>aa",
				function()
					require'align'.align_to_char({
						length = 1,
					})
				end,
				desc = "Aligns to 1 character",
				mode = "x"
			},
			{
				"<leader>ad",
				function()
					require'align'.align_to_char({
						preview = true,
						length = 2
					})
				end,
				desc = "Aligns to 2 character",
				mode = "x"
			},
			{
				"<leader>aw",
				function()
					require'align'.align_to_string({
						preview = true,
						regex = false,
					})
				end,
				desc = "Aligns to a string with previews",
				mode = "x"
			},
			{
				"<leader>ar",
				function()
					require'align'.align_to_string({
						preview = true,
						regex = true,
					})
				end,
				desc = "Aligns to a Vim regex with previews",
				mode = "x"
			},
		}
	}
}
