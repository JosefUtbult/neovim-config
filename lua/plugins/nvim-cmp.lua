
packages = {
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
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>at",
				"<CMD>ToggleAutoComplete<CR>",
				desc = "Toggle auto complete",
			},
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local compare = cmp.config.compare

			-- Load friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			local filter_text = function(entry, _)
				return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<S-Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.close(),
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function(fallback)
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
					{ name = "codeium",       entry_filter = filter_text, priority = 1    },
					{ name = "nvim_lsp",      entry_filter = filter_text, priority = 10   },
					{ name = "nvim_lua",      entry_filter = filter_text, priority = 10   },
					{ name = "luasnip",       entry_filter = filter_text, priority = 10   },
					{ name = "buffer",        entry_filter = filter_text, priority = 10   },
					{ name = "path",          entry_filter = filter_text, priority = 10   },
					{ name = "nvim_lua",      entry_filter = filter_text, priority = 10   },
					{ name = "obsidian.nvim", entry_filter = filter_text, priority = 10   },
					{ name = "zsh",           entry_filter = filter_text, priority = 10   },
					{ name = "latex_symbols", entry_filter = filter_text, priority = 10   },
					{ name = "latex_symbols", entry_filter = filter_text, priority = 10   },
					{ name = "jupynium",      entry_filter = filter_text, priority = 1000 },
				},
				sorting = {
					priority_weight = 1.0,
					comparators = {
						compare.score, -- Jupyter kernel completion shows prior to LSP
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
	}
}

-- No AI on Clavia thank you
if(os.getenv("CLAVIA") == nil) then
	table.insert(packages, {
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- This is the wrong way around, but that is what codeium recommends
			-- "hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
			enable_cmp_source = true,
			virtual_text = {
				enabled = true,
				manual = false,
				default_filetype_enabled = true,
				idle_delay = 75,
				virtual_text_priority = 1,
				map_keys = true,
				accept_fallback = nil,
				use_lsp = true,
				key_bindings = {
					accept = "<S-Tab>",
					accept_word = false,
					accept_line = false,
					clear = false,
					next = "<C-n>",
					prev = "<C-p>",
				}
			}
		})
		end
	})
end

return packages

