return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		-- enabled = false,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			win = {
				border = "single"
			},
			-- triggers_blacklist = {
			-- 	n = { "<", ">", "<c-t>", "<c-n>", "<c-p>" },
			-- 	i = { "<", ">", "<c-t>", "<c-n>", "<c-p>", "j", "k", ";", "q" },
			-- 	v = { "<", ">", "<c-t>", "<c-n>", "<c-p>", "j", "k", ";" },
			-- },
		}
	}
}
