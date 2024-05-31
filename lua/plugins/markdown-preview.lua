return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
		config = function()
			-- Toggle preview window
			vim.keymap.set('n', '<leader>mp', '<Plug>MarkdownPreviewToggle')
		end
	}
}

