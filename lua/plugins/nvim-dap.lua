-- taken from lazyvim
---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
	local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
	config = vim.deepcopy(config)
	---@cast args string[]
	config.args = function()
		local new_args = vim.fn.input("run with args: ", table.concat(args, " ")) --[[@as string]]
		return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
	end
	return config
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"stevearc/overseer.nvim",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
			"abayomi185/nvim-dap-probe-rs",
			"rcarriga/nvim-dap-ui",
			"thehamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")

			function selectTarget()
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				local conf = require("telescope.config").values
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")
				return coroutine.create(function(coro)
					local opts = {}
					pickers
						.new(opts, {
							prompt_title = "path to executable",
							finder = finders.new_oneshot_job(
								{ "fdfind", "--hidden", "--no-ignore", "--type", "x" },
								{}
							),
							sorter = conf.generic_sorter(opts),
							attach_mappings = function(buffer_number)
								actions.select_default:replace(function()
									actions.close(buffer_number)
									coroutine.resume(coro, action_state.get_selected_entry()[1])
								end)
								return true
							end,
						})
						:find()
				end)
			end

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
			dap.configurations.rust = {
				{
					type = 'probe-rs-debug',
					request = 'launch',
					name = 'Probe-rs debug',
					program = selectTarget,
				},
				{
					name = "CodeLLDB debug",
					type = "codelldb",
					request = "launch",
					program = selectTarget,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = true
				},
			}
			dap.configurations.cpp = {
				{
					name = "CodeLLDB",
					type = "codelldb",
					request = "launch",
					program = selectTarget,
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

		keys = {
			{
				"<f7>",
				function()
					require("dap").step_over()
				end,
				desc = "step over",
			},
			{
				"<f8>",
				function()
					require("dap").step_into()
				end,
				desc = "step into",
			},
			{
				"<f9>",
				function()
					require("dap").step_out()
				end,
				desc = "step out",
			},
			{
				"<f12>",
				function()
					require("dap").continue()
				end,
				desc = "continue",
			},
			{
				"<leader>da",
				function()
					require("dap").continue()
				end,
				desc = "Run",
			},
			{
				"<leader>dar",
				function()
					require("dap").continue({ before = get_args })
				end,
				desc = "run with args",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "toggle breakpoint",
			},
			{
				"<leader>dbb",
				function()
					require("dap").set_breakpoint(vim.fn.input("breakpoint condition: "))
				end,
				desc = "breakpoint condition",
			},
			{
				"<leader>dc",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "run to cursor",
			},
			{
				"<leader>dd",
				function()
					local dap = require("dap")
					dap.disconnect({ terminatedebuggee = true })
					dap.close()
				end,
				desc = "Disconnect"
			},
			{
				"<leader>dg",
				function()
					require("dap").goto_()
				end,
				desc = "Goto line",
			},
			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "Down",
			},
			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "Up",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run last",
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "Pause",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle repl",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},
		},
	},
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			-- point dap-python to system python as debugpy is installed as system python package
			require("dap-python").setup("/usr/bin/python")
		end,
		-- keys = {
		--	{
		--		"<leader>dl",
		--		function()
		--			require("dap-python").test_class()
		--		end,
		--		desc = "test class (python)",
		--	},
		--	{
		--		"<leader>dm",
		--		function()
		--			require("dap-python").test_method()
		--		end,
		--		desc = "test method (python)",
		--	},
		--	{
		--		"<leader>ds",
		--		function()
		--			require("dap-python").debug_selection()
		--		end,
		--		mode = { "v" },
		--		desc = "debug selection (python)",
		--	},
		-- },
	},
	{
		"abayomi185/nvim-dap-probe-rs",
		config = function()
			require('dap-probe-rs').setup()
		end
	},
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
			{ "<leader>rb", function() require("overseer").load_task_bundle() end, desc = "Load bundle" },
			{
				"<leader>rB",
				function() require("overseer").save_task_bundle(nil, nil, { on_conflict = "overwrite" }) end,
				desc = "Save bundle",
			},
			{ "<leader>rd", function() require("overseer").delete_task_bundle() end, desc = "Delete bundle" },
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
			{ "<leader>rl", function() require("overseer").list_task_bundles() end, desc = "List bundles" },
			{ "<leader>ra", "<cmd>OverseerQuickAction<cr>", desc = "Quick action" },
			{ "<leader>rr", function() require("overseer").run_template({ prompt = "missing" }) end, desc = "Template task" },
			{ "<leader>rR", "<cmd>OverseerRestartLast<cr>", desc = "Rerun most recent task" },
			{
				"<leader>rt",
				function() require("overseer").toggle({ direction = "left" }) end,
				desc = "Toggle Overseer task list",
			},
			{ "<leader>rs", "<cmd>OverseerRunCmd<cr>", desc = "Raw shell command" },
		},
	},

}
