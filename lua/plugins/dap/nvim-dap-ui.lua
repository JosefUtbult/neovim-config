local debug_keymap_active = false

local function toggle_keymap()
	local dap = require("dap")

	-- Function to toggle keymap
	if debug_keymap_active then
		print("Disabling debug keymap")

		vim.api.nvim_del_keymap("n", "bb")
		vim.api.nvim_del_keymap("n", "BB")
		vim.api.nvim_del_keymap("n", "c")
		vim.api.nvim_del_keymap("n", "sb")
		vim.api.nvim_del_keymap("n", "u")
		vim.api.nvim_del_keymap("n", "n")
		vim.api.nvim_del_keymap("n", "s")
		vim.api.nvim_del_keymap("n", "gl")
		vim.api.nvim_del_keymap("n", "X")
		vim.api.nvim_del_keymap("n", "*")
	else
		print("Enabling debug keymap")

		vim.api.nvim_set_keymap(
			"n",
			"bb",
			"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"BB",
			"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"c",
			"<cmd>lua if vim.bo.filetype ~= 'dap-float' then require'dap'.continue() end<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"sb",
			"<cmd>lua if vim.bo.filetype ~= 'dap-float' then require'dap'.step_back() end<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"u",
			"<cmd>lua if vim.bo.filetype ~= 'dap-float' then require'dap'.step_out() end<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"n",
			"<cmd>lua if vim.bo.filetype ~= 'dap-float' then require'dap'.step_over() end<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"s",
			"<cmd>lua if vim.bo.filetype ~= 'dap-float' then require'dap'.step_into() end<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap("n", "gl", "<cmd>lua debug_run_last()<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "X", "<cmd>lua require'dap'.terminate()<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap(
			"n",
			"*",
			"<cmd>lua require'dap'.run_to_cursor()<CR>",
			{ noremap = true, silent = true }
		)
	end
	debug_keymap_active = not debug_keymap_active
end

return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"stevearc/overseer.nvim",
		},
		keys = {
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				mode = { "n", "v" },
				desc = "eval",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "toggle dap ui",
			},
			{
				"<leader>da",
				function()
					require("dap").continue()
				end,
				desc = "Run",
			},
			{
				"<leader>d",
				toggle_keymap,
				desc = "Toggle debug keymap",
			},
		},
		opts = {
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "left",
					size = 100,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 15,
				},
			},
		},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			-- let overseer patch dap
			local has_overseer, overseer = pcall(require, "overseer")
			if has_overseer then
				overseer.patch_dap(true)
				require("dap.ext.vscode").json_decode = require("overseer.json").decode
			end

			--- Setup DapUi
			-- vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> <q> <cmd>close!<CR>'
			-- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			-- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			-- dap.listeners.before.event_exited['dapui_config'] = dapui.close
		end,
	},
}
