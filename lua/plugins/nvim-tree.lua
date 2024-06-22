-- Nvim-tree file browser

return {
	{
		'nvim-tree/nvim-tree.lua',
		-- Icons pack for the file browser
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',
		},
		keys = {
			{
				'<C-n>',
				':NvimTreeFindFileToggle<CR>',
				desc = "NvimTree toggle",
				silent = true
			}
		},
		config = function()
			require('nvim-tree').setup()

			-- Disable netrw
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	}
}

