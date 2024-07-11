return {
	{
		"williamboman/mason.nvim",
		config = function()
			require('mason').setup()
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
					"spell"
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
