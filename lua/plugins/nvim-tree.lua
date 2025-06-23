-- Nvim-tree file browser

return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		-- Icons pack for the file browser
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("nvim-tree").setup()

			-- Disable netrw
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},
}
