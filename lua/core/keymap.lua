vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Map jj to escape
vim.keymap.set('i', 'jj', '<Esc>')
-- Clear the search on <leader>h
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
