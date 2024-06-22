return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>of",
				":ObsidianQuickSwitch<CR>",
				desc = "Open Obsidian quick switch"
			},
			{
				"<leader>og",
				":ObsidianSearch<CR>",
				desc = "Open Obsidian search"
			},
			{
				"<leader>on",
				":ObsidianNew<CR>",
				desc = "Create new note in Obsidian vault"
			},
			{
				"<leader>ob",
				":ObsidianBacklinks<CR>",
				desc = "Open Obsidian backlinks"
			},
			{
				"<leader>ot",
				":ObsidianToggleCheckbox<CR>",
				desc = "Open Obsidian toggle checkbox"
			},
			{
				"<leader>or",
				":ObsidianRename<CR>",
				desc = "Obsidian rename"
			},
		},
		opts = {
			workspaces = {
				{
					name = "Josefs Vault",
					path = "~/vault",
				},
			},
			follow_url_func = function(url)
				vim.fn.jobstart({"xdg-open", url})
			end,
			templates = {
				folder = "Misc/Templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},
			notes_subdir = "Inbox",
			new_notes_location = "notes_subdir",
			note_id_func = function(title)
				return title .. ".md"
			end,
			preferred_link_style = "wiki",
		},
	}
}
