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
		"ltex",
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
		"arduino_language_server"
	}
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
lspconfig.ltex.setup({})
lspconfig.autotools_ls.setup({})
lspconfig.marksman.setup({})
lspconfig.jedi_language_server.setup({})
lspconfig.yamlls.setup({})
lspconfig.lemminx.setup({})
lspconfig.arduino_language_server.setup({})

-- Activate hover
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
-- Go to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
-- Go to implementation
vim.keymap.set('n', 'gf', vim.lsp.buf.implementation, {})
-- Open code actions
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

-- <C-x><C-o>: Code compleation
