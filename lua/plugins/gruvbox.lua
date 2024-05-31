-- Gruvbox theme
-- If changed, remember to change in LuaLine

return {
	{
		'ellisonleao/gruvbox.nvim',
		enabled = false,
		lazy = false,
		priority = 1000 ,
		config = function()
			require("gruvbox").setup({
				transparent_mode = true
			})
			vim.cmd [[ colorscheme gruvbox ]]
		end,
	}
}

