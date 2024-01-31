require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		-- Lua
		"lua_ls",
		-- JS
		"tsserver",
		-- Bash
		"bashls",
		-- C/C++
		"clangd",
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
	},
})

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({})
lspconfig.tsserver.setup({})
lspconfig.bashls.setup({})
lspconfig.clangd.setup({})
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
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }

		-- Activate hover
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		-- Go to definition
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		-- Go to implementation
		vim.keymap.set("n", "gf", vim.lsp.buf.implementation, opts)
		-- Open code actions
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		-- <C-x><C-o>: Code compleation
	end,
})
