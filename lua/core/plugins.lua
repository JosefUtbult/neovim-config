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
	-- Adds indentation lines
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {}
	},
	-- Sets file indentation based on the actual file
	-- by making a dumb check for indentation styles
	{
		'Darazaki/indent-o-matic'
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
	-- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
	{
		"folke/trouble.nvim",
		branch = "dev",
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
	-- Markdown previewer
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	-- Markdown navigation and notebook tools
	{
		"jakewvincent/mkdnflow.nvim",
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	-- Wrapping modes:
	--	[ow - soft wrap mode
	--	]ow - hard wrap mode
	--	yow - toggle wrap mode
	{
		"andrewferrier/wrapping.nvim"
	},
	-- Debugging
	-- Debug Adapter Protocol client implementation
	{
		"mfussenegger/nvim-dap"
	},
	-- Task runner and job management plugin
	{
		"stevearc/overseer.nvim"
	}
}

