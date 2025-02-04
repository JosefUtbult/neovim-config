return {
	{
		"stevearc/overseer.nvim",
		opts = {
			dap = false,
			component_aliases = {
				default_vscode = {
					"default",
					"on_output_quickfix"
				},
			},
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
						{ "on_output_quickfix", open = not params.bang, open_height = 8, close = true },
						"default",
					},
				})
				task:start()
			end, {
				desc = "Run make as an Overseer task",
				nargs = "*",
				bang = true,
			})

			-- Define Cygwin Make command
			vim.api.nvim_create_user_command("Cygmake", function(params)
				-- Insert args at the '$*' in the makeprg
				local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
				if num_subs == 0 then
					cmd = cmd .. " " .. params.args
				end
				local task = require("overseer").new_task({
					cmd = "cygwin -c \"" .. vim.fn.expandcmd(cmd) .. "\"",
					components = {
						{ "on_output_quickfix", open = not params.bang, open_height = 8, close = true },
						"default",
					},
				})
				task:start()
			end, {
				desc = "Run make in cygwin as an Overseer task",
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
			{ "<leader>rl", "<cmd>OverseerRestartLast<cr>", desc = "Rerun most recent task" },
			{
				"<leader>rt",
				function() require("overseer").toggle({ direction = "right" }) end,
				desc = "Toggle Overseer task list",
			},
			{ "<leader>rs", "<cmd>OverseerRunCmd<cr>", desc = "Raw shell command" },
		},
	},
}
