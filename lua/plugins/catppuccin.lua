require("catppuccin").setup({
	flavour = "macchiato",
	transparent_background = true,
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
})

vim.cmd.colorscheme "catppuccin"
