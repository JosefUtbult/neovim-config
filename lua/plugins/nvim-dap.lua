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
			"rcarriga/nvim-dap-ui",
			"thehamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
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
			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
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
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = true,
				},
			}
			-- dap.adapters.lldb = {
			-- 	type = "executable",
			-- 	command = os.getenv("HOME")
			-- 		.. "/.local/share/nvim/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			-- 	name = "lldb",
			-- }
			-- dap.configurations.cpp = {
			-- 	{
			-- 		name = "launch",
			-- 		type = "lldb",
			-- 		request = "launch",
			-- 		cwd = "${workspacefolder}",
			-- 		stoponentry = false,
			-- 		args = {},
			-- 		program = function()
			-- 			local pickers = require("telescope.pickers")
			-- 			local finders = require("telescope.finders")
			-- 			local conf = require("telescope.config").values
			-- 			local actions = require("telescope.actions")
			-- 			local action_state = require("telescope.actions.state")
			-- 			return coroutine.create(function(coro)
			-- 				local opts = {}
			-- 				pickers
			-- 					.new(opts, {
			-- 						prompt_title = "path to executable",
			-- 						finder = finders.new_oneshot_job(
			-- 							{ "fd", "--hidden", "--no-ignore", "--type", "x" },
			-- 							{}
			-- 						),
			-- 						sorter = conf.generic_sorter(opts),
			-- 						attach_mappings = function(buffer_number)
			-- 							actions.select_default:replace(function()
			-- 								actions.close(buffer_number)
			-- 								coroutine.resume(coro, action_state.get_selected_entry()[1])
			-- 							end)
			-- 							return true
			-- 						end,
			-- 					})
			-- 					:find()
			-- 			end)
			-- 		end,
			-- 	},
			-- 	{
			-- 		name = "attach to process",
			-- 		type = "lldb",
			-- 		request = "attach",
			-- 		pid = require("dap.utils").pick_process,
			-- 		args = {},
			-- 	},
			-- }
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp
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
			-- {
			-- 	"<leader>dl",
			-- 	function()
			-- 		require("dap").run_last()
			-- 	end,
			-- 	desc = "Run last",
			-- },
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
		keys = {
			{
				"<leader>dl",
				function()
					require("dap-python").test_class()
				end,
				desc = "test class (python)",
			},
			{
				"<leader>dm",
				function()
					require("dap-python").test_method()
				end,
				desc = "test method (python)",
			},
			{
				"<leader>ds",
				function()
					require("dap-python").debug_selection()
				end,
				mode = { "v" },
				desc = "debug selection (python)",
			},
		},
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
}
