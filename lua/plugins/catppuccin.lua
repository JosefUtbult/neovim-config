return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "macchiato",
			transparent_background = true,
			color_overrides = {
				all = {
					-- Use the nice peach color instead of the standard blue
					blue = "#f5a97f",
				},
			},
			integrations = {
				mason = true,
				neotree = true,
				lsp_trouble = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
						ok = { "undercurl" },
					},
					inlay_hints = {
						background = true,
				},
				},
			}
		},
		-- For some reason, catppuccin won't load opts by itself...
		config = function(_, opts)
			-- setup must be called before loading
			require('catppuccin').setup(opts)
			vim.cmd.colorscheme "catppuccin"
		end,
	}
}
