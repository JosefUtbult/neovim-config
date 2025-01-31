local rust_find_target = require("utils.rust_find_target")
local select_target = require("utils.select_target")

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"stevearc/overseer.nvim",
			"nvim-telescope/telescope.nvim",
			"abayomi185/nvim-dap-probe-rs",
			"rcarriga/nvim-dap-ui",
			"thehamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dap_ui = require("dapui")
			local dap_virtual_text = require("nvim-dap-virtual-text");

			-- Setup virtual text
			dap_virtual_text.setup({ virt_text_pos = "eol" })

			-- Setup hydra statusline

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
				name = "cppdbg",
				type = "executable",
				command = os.getenv("HOME") .. "/lldb-vscode/OpenDebugAD7",
				-- command = vim.fn.stdpath("data") .. "/lldb-vscode/lldb-vscode",
				-- command = vim.fn.stdpath("data") .. "/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}

			dap.adapters.cppdbg = {
				name = "cppdbg",
				type = "executable",
				command = os.getenv("HOME") .. "/lldb-vscode/OpenDebugAD7",
				-- command = vim.fn.stdpath("data") .. "/lldb-vscode/lldb-vscode",
				-- command = vim.fn.stdpath("data") .. "/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}

			dap.configurations.rust = {
				{
					type = "probe-rs-debug",
					request = "launch",
					name = "Probe-rs debug",
					chip = "stm32f401RETx",
					coreConfigs = {
						{
							programBinary = function()
								local bufname = vim.api.nvim_buf_get_name(0) -- Get current buffer path
								local executable = rust_find_target.findExecutablePath(bufname)
								if executable then
									return executable
								else
									error(
										"Could not find Rust executable. Make sure Cargo.toml exists and .cargo/config.toml has a valid target."
									)
								end
							end,
						},
					},
				},
				{
					name = "CodeLLDB debug",
					type = "codelldb",
					request = "launch",
					program = select_target,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = true,
				},
			}

			dap.configurations.cpp = {
				{
					name = "CodeLLDB",
					type = "codelldb",
					request = "launch",
					program = select_target,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = true,
				},
			}
			dap.configurations.c = dap.configurations.cpp

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
	-- Task runner
	{
		"stevearc/overseer.nvim",
		opts = {
			dap = false,
		},
		config = function(_, opts)
			require("overseer").setup(opts)

			-- Define Make command
			vim.api.nvim_create_user_command("Make", function(params)
				-- Insert args at the '$*' in the makeprg
				local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
				if num_subs == 0 then
					cmd = cmd .. " " .. params.args
				end
				local task = require("overseer").new_task({
					cmd = vim.fn.expandcmd(cmd),
					components = {
						{ "on_output_quickfix", open = not params.bang, open_height = 8, open_on_exit = "failure" },
						"default",
					},
				})
				task:start()
			end, {
				desc = "Run your makeprg as an Overseer task",
				nargs = "*",
				bang = true,
			})

			-- Define command to rerun most recent task
			vim.api.nvim_create_user_command("OverseerRestartLast", function()
				local overseer = require("overseer")
				local tasks = overseer.list_tasks({ recent_first = true })
				if vim.tbl_isempty(tasks) then
					vim.notify("No tasks found", vim.log.levels.WARN)
				else
					overseer.run_action(tasks[1], "restart")
				end
			end, {})
		end,

		keys = {
			{
				"<leader>rb",
				function()
					require("overseer").load_task_bundle()
				end,
				desc = "Load bundle",
			},
			{
				"<leader>rB",
				function()
					require("overseer").save_task_bundle(nil, nil, { on_conflict = "overwrite" })
				end,
				desc = "Save bundle",
			},
			{
				"<leader>rd",
				function()
					require("overseer").delete_task_bundle()
				end,
				desc = "Delete bundle",
			},
			{
				"<leader>rD",
				function()
					local overseer = require("overseer")
					local tasks = overseer.list_tasks({ unique = false, status = "RUNNING", status_not = true })
					for _, task in ipairs(tasks) do
						overseer.run_action(task, "dispose")
					end
				end,
				desc = "Dispose all non-running tasks",
			},
			{
				"<leader>rl",
				function()
					require("overseer").list_task_bundles()
				end,
				desc = "List bundles",
			},
			{ "<leader>ra", "<cmd>OverseerQuickAction<cr>", desc = "Quick action" },
			{
				"<leader>rr",
				function()
					require("overseer").run_template({ prompt = "missing" })
				end,
				desc = "Template task",
			},
			{ "<leader>rR", "<cmd>OverseerRestartLast<cr>", desc = "Rerun most recent task" },
			{
				"<leader>rt",
				function()
					require("overseer").toggle({ direction = "left" })
				end,
				desc = "Toggle Overseer task list",
			},
			{ "<leader>rs", "<cmd>OverseerRunCmd<cr>", desc = "Raw shell command" },
		},
	},
}
