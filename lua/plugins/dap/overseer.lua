return {
	{
		"stevearc/overseer.nvim",
		dependencies = {
			"akinsho/toggleterm.nvim",
		},
		config = function(opts)
			require("overseer").setup({
				dap = false,
				auto_detect_success_color = true,
				strategy = {
					"toggleterm",
					direction = "tab",
					auto_scroll = true,
					close_on_exit = false,
					quit_on_exit = "never",
					persist_mode = true,
					keepalive = true,
					insert_mappings = true,
					terminal_mappings = true,
					go_back = 0,
				},
				-- Disable all inbuilt task providers. I'd rather make my own tasks
				templates = {},
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
			{ "<leader>rl", "<cmd>OverseerRestartLast<cr>", desc = "Rerun most recent task" },
			{
				"<leader>rt",
				function()
					require("overseer").toggle({ direction = "right" })
				end,
				desc = "Toggle Overseer task list",
			},
			{ "<leader>rs", "<cmd>OverseerRunCmd<cr>", desc = "Raw shell command" },
		},
	}
}
