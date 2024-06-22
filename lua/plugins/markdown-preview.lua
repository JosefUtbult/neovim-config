return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
		keys = {
			'<leader>mp',
			'<Plug>MarkdownPreviewToggle',
			desc = "Toggle Markdown Preview"
		},
	}
}

