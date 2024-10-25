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
				"lua_ls",
				"ts_ls",
				"bashls",
				"clangd",
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
