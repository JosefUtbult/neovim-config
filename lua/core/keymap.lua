vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Map jj to escape
vim.keymap.set('i', 'jj', '<Esc>')
-- Clear the search on <leader>h
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
-- Go to the end of the line with qq
vim.keymap.set('i', 'qq', '<C-O><End>')

-- Set the timeout length between chained key presses
vim.o.timeoutlen = 600
