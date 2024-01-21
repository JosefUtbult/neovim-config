-- Initialize Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- Theme
	{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true},
	-- File browser
	{ 'nvim-tree/nvim-tree.lua' },
	-- Icons pack for the file browser
	{ 'nvim-tree/nvim-web-devicons' },
	-- Status line
	{ 'nvim-lualine/lualine.nvim' },
	-- Syntax highlighting
	{ 'nvim-treesitter/nvim-treesitter' },
	-- Fuzzy finder over lists
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		requires = {{'nvim-lua/plenary.nvim'}}
	},
	-- Auto apply hard or soft wrapping
	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup()
		end,
	},
	-- Adds indentation lines
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	-- Enables spelling rotation
	{ 'tweekmonster/spellrotate.vim' },
	-- Comment toggling
	{ 'tpope/vim-commentary' }
}
local opts = {}

require("lazy").setup(plugins, opts)
