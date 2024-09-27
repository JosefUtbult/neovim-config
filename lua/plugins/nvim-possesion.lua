return {
	{
		"gennaro-tedesco/nvim-possession",
		dependencies = {
			"ibhagwan/fzf-lua",
		},
		build = function()
			-- Auto create the sessions folder
			local sessions_path = vim.fn.stdpath("data") .. "/sessions"
			if vim.fn.isdirectory(sessions_path) == 0 then
				vim.uv.fs_mkdir(sessions_path, 511) -- 0777
			end
		end,
		config = true,
		init = function()
			local possession = require("nvim-possession")
			vim.keymap.set("n", "<leader>sl", function()
				possession.list()
			end)
			vim.keymap.set("n", "<leader>sn", function()
				possession.new()
			end)
			vim.keymap.set("n", "<leader>su", function()
				possession.update()
			end)
			vim.keymap.set("n", "<leader>sd", function()
				possession.delete()
			end)
		end,
	},
}
