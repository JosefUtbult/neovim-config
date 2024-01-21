-- Check if packer is installed. Install it otherwise
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- Plugins
	use 'wbthomason/packer.nvim'
	-- Theme
	use 'ellisonleao/gruvbox.nvim'
	-- File browser
	use 'nvim-tree/nvim-tree.lua'
	-- Icons pack for the file browser
	use 'nvim-tree/nvim-web-devicons'
	-- Status line
	use 'nvim-lualine/lualine.nvim'
	-- Syntax highlighting
	use 'nvim-treesitter/nvim-treesitter'
	-- Fuzzy finder over lists
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		requires = {{'nvim-lua/plenary.nvim'}}
	}
	-- Auto apply hard or soft wrapping
	use {
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup()
		end,
	}
	-- Adds indentation lines
	use 'lukas-reineke/indent-blankline.nvim'
	-- Enables spelling rotation
	use 'tweekmonster/spellrotate.vim'
	-- Comment toggling
	use 'tpope/vim-commentary'

	if packer_bootstrap then
		require('packer').sync()
	end
end)
