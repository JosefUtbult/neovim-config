-- Telescope fuzzy finder

local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")

require('telescope').setup({
	file_ignore_patterns = { "node%_modules/.*" },
	defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})

local builtin = require('telescope.builtin')

local opts = { noremap = true, silent = true }

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

-- Toggle keymap search
vim.keymap.set('n', '<leader>?', ':Telescope keymaps<CR>')

-- Search previously open files
vim.keymap.set('n', '<leader><leader>', builtin.oldfiles, opts)

-- Search files in workspace
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)

-- Search in help tags
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)

-- Search in open buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('v', '<leader>fb', function()
	local text = vim.getVisualSelection()
	builtin.buffers({ default_text = text })
end, opts)

-- Search in current buffer
vim.keymap.set('n', '<leader>gg', builtin.current_buffer_fuzzy_find, opts)
vim.keymap.set('v', '<leader>gg', function()
	local text = vim.getVisualSelection()
	builtin.current_buffer_fuzzy_find({ default_text = text })
end, opts)

-- Live grep
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('v', '<leader>fg', function()
	local text = vim.getVisualSelection()
	builtin.live_grep({ default_text = text })
end, opts)
