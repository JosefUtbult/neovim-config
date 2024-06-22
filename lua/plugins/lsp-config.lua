return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			'jay-babu/mason-null-ls.nvim',
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					-- Lua
					"lua_ls",
					-- JS
					"tsserver",
					-- Bash
					"bashls",
					-- C/C++
					"clangd",
					"cmake",
					-- Rust
					"rust_analyzer",
					-- CSS
					"cssls",
					-- HTML
					"html",
					-- Docker
					"dockerls",
					-- Docker Compose
					"docker_compose_language_service",
					-- JSON
					"jsonls",
					-- LaTex
					--"ltex",
					-- Make
					"autotools_ls",
					-- Markdown
					"marksman",
					-- Python
					"jedi_language_server",
					-- YAML
					"yamlls",
					-- XML
					"lemminx",
					-- Arduino
					"arduino_language_server",
				}
			})
			require('mason-null-ls').setup({
				automatic_installation = true,
				ensure_installed = {
					"stylua",
					"checkmake",
					"cppcheck",
					"hadolint",
					"black",
					"isort",
					"codespell",
					"spell"
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.bashls.setup({})
			lspconfig.clangd.setup({})
			lspconfig.cmake.setup({})
			lspconfig.rust_analyzer.setup({})
			lspconfig.cssls.setup({})
			lspconfig.html.setup({})
			lspconfig.dockerls.setup({})
			lspconfig.docker_compose_language_service.setup({})
			lspconfig.jsonls.setup({})
			-- lspconfig.ltex.setup({})
			lspconfig.autotools_ls.setup({})
			lspconfig.marksman.setup({})
			lspconfig.jedi_language_server.setup({})
			lspconfig.yamlls.setup({})
			lspconfig.lemminx.setup({})
			lspconfig.arduino_language_server.setup({})

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
				-- on_attach = function(client, bufnr)
				--	-- Call any formatter related to this file using the general format function in none-ls
				--	if client.server_capabilities.documentFormattingProvider then
				--		vim.keymap.set(
				--			'n',
				--			'<leader>gfg',
				--			vim.lsp.buf.format,
				--			{
				--				silent = true,
				--				buffer = bufnr,
				--			}
				--		)
				--	end
				--	if client.server_capabilities.documentRangeFormattingProvider then
				--		vim.keymap.set(
				--			'v',
				--			'<leader>gf',
				--			vim.lsp.buf.format,
				--			{
				--				silent = true,
				--				buffer = bufnr,
				--				range = {
				--					["start"] = vim.api.nvim_buf_get_mark(0, "<"),
				--					["end"] = vim.api.nvim_buf_get_mark(0, ">")
				--				}
				--			}
				--		)
				--	end
				-- end,
			})
		end,
	},
	-- Lightweight yet powerful formatter plugin for Neovim
	{
		"stevearc/conform.nvim",
		enabled = true,
		-- event = { "BufWritePre" },
		-- cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>gfg",
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
