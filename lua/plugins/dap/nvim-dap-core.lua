local rust_find_target = require("utils.rust_find_target")
-- local select_target = require("utils.select_target")

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope.nvim",
			"abayomi185/nvim-dap-probe-rs",
			"rcarriga/nvim-dap-ui",
			"thehamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dap_virtual_text = require("nvim-dap-virtual-text");

			-- Setup virtual text
			dap_virtual_text.setup({ virt_text_pos = "eol" })

			dap.adapters.executable = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				name = "lldb",
				host = "127.0.0.1",
				port = 13000,
			}
			dap.adapters.codelldb = {
				name = "codelldb server",
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}
			dap.adapters.cppdbg = {
				name = "GDB (VSCode)",
				type = "executable",
				command = vim.fn.stdpath("data") .. "/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}

			-- Set signs, stolen from Rickard
			local icons = require("core.icons").icons
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
			for name, sign in pairs(icons.dap) do
				sign = type(sign) == "table" and sign or { sign }
				vim.fn.sign_define(
					"Dap" .. name,
					{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
				)
			end
		end,
	},
	{
		"abayomi185/nvim-dap-probe-rs",
		config = function()
			require("dap-probe-rs").setup()
		end,
	},
}
