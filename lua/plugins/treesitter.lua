return {
	{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
			require('nvim-treesitter.configs').setup {
				-- A list of parser names, or "all"
				ensure_installed = {
					"c",
					"lua",
					"rust",
					"ruby",
					"vim",
					"html",
					"markdown_inline",
					"vimdoc",
					"python",
					"bash"
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			}
    end,
	}
}

