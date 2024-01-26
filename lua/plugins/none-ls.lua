local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- Builtin formatters
		null_ls.builtins.formatting.stylua,
		-- Javascript linter
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
		-- Makefile diagnostics
		null_ls.builtins.diagnostics.checkmake,
		-- Latex diagnostics
		null_ls.builtins.diagnostics.chktex,
		-- C++ diagnostics
		null_ls.builtins.diagnostics.cppcheck,
		null_ls.builtins.diagnostics.cpplint,
		-- Docker files
		null_ls.builtins.diagnostics.hadolint,
		-- Python
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort
	},
})

-- Call any formatter related to this file using the general format function in none-ls
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
