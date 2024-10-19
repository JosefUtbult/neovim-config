return {
	{
		"williamboman/mason.nvim",
		config = function(opts)
			require('mason').setup(opts)
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			automatic_installation = true,
			ensure_installed = {
				-- Lua
				"lua_ls",
				-- JS
				"ts_ls",
				-- Bash
				"bashls",
				-- C/C++
				"clangd",
				"cmake",
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
			},
			config = function(opts)
				require('mason-lspconfig').setup(opts)
			end
		},
		{
			"jay-babu/mason-null-ls.nvim",
			dependencies = {
				"williamboman/mason.nvim",
				"nvimtools/none-ls.nvim",
			},
			opts = {
				automatic_installation = true,
				ensure_installed = {
					"stylua",
					"checkmake",
					"cppcheck",
					"hadolint",
					"black",
					"isort",
					"codespell",
					"spell",
					"rust-analyzer"
				},
			}
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = {
				"williamboman/mason.nvim",
				"mfussenegger/nvim-dap",
			},
			opts = {
				ensure_installed = {
					"codelldb",
					"python",
				}
			}
		}
	}
}
