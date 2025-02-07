return {
	{
		'jedrzejboczar/exrc.nvim',
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-telescope/telescope.nvim',
			'jghauser/mkdir.nvim'
		},
		config = function()
			local settings_path = '.nvim/config.lua'
			if os.getenv("CLAVIA") == "true" then
				settings_path = '.jutb/nvim/config.lua'
			end

			require('exrc').setup({
				exrc_name = settings_path,
				trust_on_write = true,
				use_telescope = true
			})
		end,

	},
	{
		'jghauser/mkdir.nvim'
	}
}
