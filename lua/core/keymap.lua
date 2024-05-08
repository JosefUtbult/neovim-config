vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set the timeout length between chained key presses
vim.o.timeoutlen = 600

-- Map jj to escape
vim.keymap.set('i', 'jj', '<Esc>')
-- Clear the search on <leader>h
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
-- Go to the end of the line with qq
vim.keymap.set('i', 'qq', '<C-O><End>')

-- Reverse lines in visual mode
vim.keymap.set('v', 't', ':!tac<CR>')

-- Tab behaviour
vim.keymap.set('n', 'tn',        ':tabnew<CR>')
vim.keymap.set('n', 't<leader>', ':tabnext<CR>')
vim.keymap.set('n', 'tm',				 ':tabmove<CR>')
vim.keymap.set('n', 'tc', 			 ':tabclose<CR>')
vim.keymap.set('n', 'to', 			 ':tabonly<CR>')
