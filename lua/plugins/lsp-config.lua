return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/cmp-nvim-lsp"
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.cmake.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.cssls.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.dockerls.setup({ capabilities = capabilities })
			lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })
			-- lspconfig.ltex.setup({ capabilities = capabilities })
			lspconfig.autotools_ls.setup({ capabilities = capabilities })
			lspconfig.marksman.setup({ capabilities = capabilities })
			lspconfig.jedi_language_server.setup({ capabilities = capabilities })
			lspconfig.yamlls.setup({ capabilities = capabilities })
			lspconfig.lemminx.setup({ capabilities = capabilities })
			lspconfig.arduino_language_server.setup({ capabilities = capabilities })

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					-- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
					vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
					vim.keymap.set("n", "gD", "<cmd>Telescope diagnostics<CR>", opts)
					vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
					vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

					-- Toggle virtual text
					local isLspDiagnosticsVisible = true
					vim.keymap.set("n", "<leader>ax", function()
						isLspDiagnosticsVisible = not isLspDiagnosticsVisible
						vim.diagnostic.config({
							virtual_text = isLspDiagnosticsVisible,
						}) end)
					end,
			})
		end
	},
	-- Allow NeoVim to act as a language server to connect to
	-- command line tools such as linters and formatters
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Builtin formatters
					null_ls.builtins.formatting.stylua,
					-- Makefile diagnostics
					null_ls.builtins.diagnostics.checkmake,
					-- C++ diagnostics
					null_ls.builtins.diagnostics.cppcheck.with({
						args = {
							"--enable=warning,style,performance,portability",
							"--template=g++",
							"--std",
							"$FILENAME"
						}
					}),
					-- C++ formatting
					null_ls.builtins.formatting.clang_format.with({
						-- Use .clang-format
						extra_args = { "--style=file" },
					}),
					-- Docker files
					null_ls.builtins.diagnostics.hadolint,
					-- Python
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					-- Spelling
					-- null_ls.builtins.formatting.codespell,
					null_ls.builtins.completion.spell,
				},
			})
		end,
	},
	-- Lightweight yet powerful formatter plugin for Neovim
	{
		"stevearc/conform.nvim",
		enabled = true,
		keys = {
			{
				"<leader>gf",
				function()
					require("conform").format({
						async = true,
						lsp_fallback = false
					})
				end,
				mode = "n",
				desc = "Format global buffer",
			},
			{
				"<leader>gf",
				function()
					require("conform").format({
						async = true,
						lsp_fallback = false,
					})
				end,
				mode = "v",
				desc = "Format visual buffer",
			},
			{
				"<leader>cc",
				"<CMD>ClangdSwitchSourceHeader<CR>",
				mode = "n",
				desc = "Switch between header and source file"
			}
		},
		-- Everything in opts will be passed to setup()
		opts = {
			log_level = vim.log.levels.DEBUG,
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				inl = { "clang-format" },
				h		= { "clang-format" },
				c		= { "clang-format" },
				cpp = { "clang-format" },
				rust = { "rust-analyzer", lsp_format = "fallback" },
			},
			formatters = {
				clangd_format = {
					command = "clang-format",
					args = {
						"--style=file"
					}
				}
			},
			-- Disable format-on-save
			format_on_save = false,
		}
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim"
				},
				opts = { lsp = { auto_attach = true } }
			}
		},
	},
	-- Nicer looking LSP output
	{
		"j-hui/fidget.nvim",
		tag = "v1.4.5",
	}
}
