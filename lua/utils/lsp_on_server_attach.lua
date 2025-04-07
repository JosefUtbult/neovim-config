local M = {}

local ignore_inline_text = {
	"clangd",
}

function M.on_attach(client, bufnr)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show context menu" })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Show code actions" })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
		buffer = bufnr,
		desc = "LSP Rename",
	})
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { buffer = bufnr, desc = "Go to LSP references" })
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = bufnr, desc = "Go to LSP definitions" })
	vim.keymap.set("n", "gD", "<cmd>Telescope diagnostics<CR>", { buffer = bufnr, desc = "Show LSP diagnostics" })
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

return M
