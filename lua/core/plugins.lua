return {
	-- Themes
	{
		'ellisonleao/gruvbox.nvim',
		priority = 1000 ,
		config = true
	},
	{
		'catppuccin/nvim',
		name = "catppuccin",
		priority = 1000
	},
	-- File browser
	{
		'nvim-tree/nvim-tree.lua',
		-- Icons pack for the file browser
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	-- Status line
	{
		'nvim-lualine/lualine.nvim'
	},
	-- Syntax highlighting
	{
		'nvim-treesitter/nvim-treesitter',
	},
	-- Fuzzy finder over lists
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	-- Integrate Telescope with LSP
	{
		'nvim-telescope/telescope-ui-select.nvim'
	},
	-- Auto apply hard or soft wrapping
	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup()
		end,
	},
	-- Adds indentation lines
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {}
	},
	-- Enables spelling rotation
	{
		'tweekmonster/spellrotate.vim'
	},
	-- Comment toggling
	{
		'tpope/vim-commentary'
	},
	-- Auto pair brackets
	{
		'LunarWatcher/auto-pairs'
	},
	-- Auto surround highlighted text with quotes and brackets
	-- Usage: cs
	{
		'tpope/vim-surround'
	},
	-- Markdown previewer
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	-- LSP server handler
	{
		"williamboman/mason.nvim"
	},
	{
		"williamboman/mason-lspconfig.nvim"
	},
	{
		"neovim/nvim-lspconfig"
	},
	{
		"nvimtools/none-ls.nvim"
	},
	-- Allow NeoVim to act as a language server to connect to
	-- command line tools such as linters and formatters
	{
		"nvimtools/none-ls.nvim",
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	-- Combine Vim and Tmux when navigating
	{
		"christoomey/vim-tmux-navigator"
	},
	-- Markdown folding
	{
		"masukomi/vim-markdown-folding"
	}
}

