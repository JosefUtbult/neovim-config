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
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
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
					{ name = 'cmp_ai',        entry_filter = filter_text },
					{ name = "nvim_lsp",      entry_filter = filter_text },
					{ name = "nvim_lua",      entry_filter = filter_text },
					{ name = "luasnip",       entry_filter = filter_text },
					{ name = "buffer",        entry_filter = filter_text },
					{ name = "path",          entry_filter = filter_text },
					{ name = "nvim_lua",      entry_filter = filter_text },
					{ name = "obsidian.nvim", entry_filter = filter_text },
					{ name = "zsh",           entry_filter = filter_text },
					{ name = "latex_symbols", entry_filter = filter_text },
					{ name = "latex_symbols", entry_filter = filter_text },
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
	packages.append({
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			-- Optionally disable cmp source if using virtual text only
			enable_cmp_source = false,
			virtual_text = {
				enabled = true,
				-- Set to true if you never want completions to be shown automatically.
				manual = false,
				-- A mapping of filetype to true or false, to enable virtual text.
				filetypes = {},
				-- Whether to enable virtual text of not for filetypes not specifically listed above.
				default_filetype_enabled = true,
				-- How long to wait (in ms) before requesting completions after typing stops.
				idle_delay = 75,
				-- Priority of the virtual text. This usually ensures that the completions appear on top of
				-- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
				-- desired.
				virtual_text_priority = 65535,
				-- Set to false to disable all key bindings for managing completions.
				map_keys = true,
				-- The key to press when hitting the accept keybinding but no completion is showing.
				-- Defaults to \t normally or <c-n> when a popup is showing. 
				accept_fallback = nil,
				-- Key bindings for managing completions in virtual text mode.
				key_bindings = {
					-- Accept the current completion.
					accept = "<Enter>",
					-- Accept the next word.
					accept_word = false,
					-- Accept the next line.
					accept_line = false,
					-- Clear the virtual text.
					clear = false,
					-- Cycle to the next completion.
					next = "<Tab>",
					-- Cycle to the previous completion.
					prev = "<C-Tab>",
				}
			}
		},
		config = function(opts)
			require("codeium").setup(opts)
		end
	})
end

return packages
