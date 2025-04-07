local configs = {}

local server_attach = require("utils.lsp_on_server_attach")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

local default_opts = {
	capabilities = capabilities,
	on_attach = server_attach.on_attach,
	inlay_hints = { enabled = true },
	document_highlight = { enabled = true },
}

for _, server in ipairs(default_servers) do
	configs[server] = default_opts
end

configs["rust_analyzer"] = {
	capabilities = capabilities,
	on_attach = server_attach.on_attach,
	inlay_hints = { enabled = true },
	document_highlight = { enabled = true },
	codelens = { enabled = true },
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = true,
				disabled = { "inactive-code" },
				enableExperimental = true,
			},
		},
	},
}

-- Clangd has some issue with inline text...
configs["clangd"] = {
	capabilities = capabilities,
	on_attach = server_attach.on_attach,
	inlay_hints = { enabled = false },
	document_highlight = { enabled = true },
}

return configs
