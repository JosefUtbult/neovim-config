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
		config = function()
			-- Disable netrw
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			-- Setup nvim-tree
			require('nvim-tree').setup({
				-- Map <C-n> to toggle NvimTree
        vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>')
			})

		end,
	}
}

