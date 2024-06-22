-- A completion engine plugin for neovim written in Lua.
-- Completion sources are installed from external repositories
-- and "sourced".

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"tamago324/cmp-zsh",
			"epwalsh/obsidian.nvim",
			"kdheepak/cmp-latex-symbols",
			"rafamadriz/friendly-snippets",
		},
		keys = {
			{
				"<leader>at",
				"<CMD>ToggleAutoComplete<CR>",
				desc = "Toggle auto complete"
			}
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local compare = cmp.config.compare

			-- Load friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "nvim_lua" },
					{ name = "obsidian.nvim" },
					{ name = "zsh" },
					{ name = "latex_symbols" },
					{ name = "latex_symbols" },
					{ name = "jupynium", priority = 1000 },
				},
				sorting = {
					priority_weight = 1.0,
					comparators = {
						compare.score,            -- Jupyter kernel completion shows prior to LSP
						compare.recently_used,
						compare.locality,
					},
				},
			})

			local cmp_enabled = true
			vim.api.nvim_create_user_command("ToggleAutoComplete", function()
				if cmp_enabled then
					require("cmp").setup.buffer({ enabled = false })
					cmp_enabled = false
					print("AutoComplete disabled")
				else
					require("cmp").setup.buffer({ enabled = true })
					cmp_enabled = true
					print("AutoComplete enabled")
				end
			end, {})
		end,
	},
}
