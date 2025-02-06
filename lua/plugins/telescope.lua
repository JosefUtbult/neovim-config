-- Telescope fuzzy finder

local function getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.5",
		dependencies = {
			"andrew-george/telescope-themes",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = {
			{
				"<leader>?",
				require("telescope.builtin").keymaps,
				desc = "Toggle keymap search",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").oldfiles({ cwd_only = true })
				end,
				desc = "Search previously open files",
				noremap = true,
				silent = true,
			},
			{
				"<leader>ff",
				require("telescope.builtin").find_files,
				desc = "Search files in workspace",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fh",
				require("telescope.builtin").diagnostics,
				desc = "Search in help tags",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fb",
				require("telescope.builtin").buffers,
				desc = "Search in open buffers (normal)",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fb",
				function()
					local text = getVisualSelection()
					require("telescope.builtin").buffers({ default_text = text })
				end,
				desc = "Search in open buffers (visual)",
				mode = "v",
				noremap = true,
				silent = true,
			},
			{
				"<leader>gg",
				require("telescope.builtin").current_buffer_fuzzy_find,
				desc = "Search in current buffer (normal)",
				noremap = true,
				silent = true,
			},
			{
				"<leader>gg",
				function()
					local text = getVisualSelection()
					require("telescope.builtin").current_buffer_fuzzy_find({ default_text = text })
				end,
				desc = "Search in current buffer (visual)",
				mode = "v",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fg",
				require("telescope.builtin").live_grep,
				desc = "Live grep (normal)",
				noremap = true,
				silent = true,
			},
			{
				"<leader>fg",
				function()
					local text = getVisualSelection()
					require("telescope.builtin").live_grep({ default_text = text })
				end,
				mode = "v",
				desc = "Live grep (visual)",
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = { ["<c-t>"] = require("trouble.sources.telescope").open },
						n = { ["<c-t>"] = require("trouble.sources.telescope").open },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				file_ignore_patterns = { "DSP" },
			})

			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("themes")
		end,
	},
}
