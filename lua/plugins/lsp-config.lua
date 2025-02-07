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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Set up each language server and enable inline hints and virtual text by default
			local default_servers = {
				"lua_ls",
				"bashls",
				"cmake",
				"cssls",
				"html",
				"dockerls",
				"docker_compose_language_service",
				"jsonls",
				"autotools_ls",
				"marksman",
				"jedi_language_server",
				"yamlls",
				"lemminx",
				"arduino_language_server",
			}

			local ignore_inline_text = {
				"clangd"
			}

			local function on_server_attach(client, bufnr)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show context menu" })
				vim.keymap.set(
					"n",
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ buffer = bufnr, desc = "Show code actions" }
				)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
					buffer = bufnr,
					desc = "LSP Rename",
				})
				vim.keymap.set(
					"n",
					"gr",
					"<cmd>Telescope lsp_references<CR>",
					{ buffer = bufnr, desc = "Go to LSP references" }
				)
				vim.keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					{ buffer = bufnr, desc = "Go to LSP definitions" }
				)
				vim.keymap.set(
					"n",
					"gD",
					"<cmd>Telescope diagnostics<CR>",
					{ buffer = bufnr, desc = "Show LSP diagnostics" }
				)
				vim.keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					{ buffer = bufnr, desc = "Go to LSP type definition" }
				)
				vim.keymap.set(
					"n",
					"gl",
					"<cmd>lua vim.diagnostic.open_float()<CR>",
					{ buffer = bufnr, desc = "Show LSP diagnostics (float)" }
				)

				-- Enable inline hints when the server attaches to a buffer
				if client.supports_method("textDocument/inlayHint") and not vim.tbl_contains(ignore_inline_text, client.name) then
					vim.lsp.inlay_hint.enable(true)
					-- Toggle inline hints
					vim.keymap.set("n", "<leader>an", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

						if vim.lsp.inlay_hint.is_enabled() then
							print("Enabled inline hints")
						else
							print("Disabled inline hints")
						end
					end, { desc = "Toggle inline hints", buffer = bufnr })
				end

				-- Enable virtual text diagnostics when the server attaches to a buffer
				if client.supports_method("textDocument/publishDiagnostics") then
					local isLspDiagnosticsVisible = true
					vim.keymap.set("n", "<leader>ax", function()
						-- Some LSPs doesn't support is_enabled
						if vim.diagnostic.is_enabled == nil then
							vim.diagnostic.enable(not vim.diagnostic.is_enabled())

							if vim.diagnostic.is_enabled() then
								print("Enabled inline diagnostics")
							else
								print("Disabled inline diagnostics")
							end
						else
							isLspDiagnosticsVisible = not isLspDiagnosticsVisible
							vim.diagnostic.config({
								virtual_text = isLspDiagnosticsVisible,
							})

							if isLspDiagnosticsVisible then
								print("Enabled inline diagnostics")
							else
								print("Disabled inline diagnostics")
							end
						end
					end, { desc = "Toggle virtual text diagnostics", buffer = bufnr })
				end
			end

			local default_opts = {
				capabilities = capabilities,
				on_attach = on_server_attach,
				inlay_hints = { enabled = true },
				document_highlight = { enabled = true },
			}

			for _, server in ipairs(default_servers) do
				lspconfig[server].setup(default_opts)
			end

			-- Clangd has some issue with inline text...
			lspconfig["clangd"].setup({
				capabilities = capabilities,
				on_attach = on_server_attach,
				inlay_hints = { enabled = false },
				document_highlight = { enabled = true },
			})

			-- Disable a warning in rust analyzer
			lspconfig["rust_analyzer"].setup({
				capabilities = capabilities,
				on_attach = on_server_attach,
				inlay_hints = { enabled = true },
				document_highlight = { enabled = true },
				codelens = { enabled = true },
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = true,
							disabled = {"inactive-code"},
							enableExperimental = true,
						}
					}
				}
			})
		end,
	},
	-- Allow NeoVim to act as a language server to connect to
	-- command line tools such as linters and formatters
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
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
							"$FILENAME",
						},
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
		keys = {
			{
				"<leader>gf",
				function()
					require("conform").format({
						async = true,
						lsp_fallback = false,
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
				desc = "Switch between header and source file",
			},
		},
		config = function()
			require('conform').setup({
				log_level = vim.log.levels.DEBUG,
				-- Define your formatters
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { { "prettierd", "prettier" } },
					inl = { "clang-format" },
					h = { "clang-format" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					rust = { "rust-analyzer", lsp_format = "fallback" },
				},
				formatters = {
					clang_format = {
						command = "clang-format",
						args = { "--style=file" },
					},
				},
				-- Disable format-on-save
				format_on_save = false,
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "v1.4.5",
	},
}
