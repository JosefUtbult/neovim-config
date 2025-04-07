return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local configs = require("utils.lsp_configs")

			for server_name, opts in pairs(configs) do
				lspconfig[server_name].setup(opts)
			end
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
			require("conform").setup({
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
