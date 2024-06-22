vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set the timeout length between chained key presses
vim.o.timeoutlen = 800

-- Map jj to escape
vim.keymap.set('i', 'jj', '<Esc>', {silent = true})
-- Clear the search on <leader>h
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', {silent = true})
-- Go to the end of the line with qq
vim.keymap.set('i', 'qq', '<C-O><End>', {silent = true})

-- Reverse lines in visual mode
vim.keymap.set('v', 't', ':!tac<CR>', {silent = true})

-- Tab behaviour
vim.keymap.set('n', '<leader><leader>', ':tabnext<CR>',  {silent = true})
vim.keymap.set('n', '<leader>n',        ':tabnew<CR>',   {silent = true})
vim.keymap.set('n', '<leader>c', 			  ':tabclose<CR>', {silent = true})
vim.keymap.set('n', '<leader>1',        '1gt',           {silent = true})
vim.keymap.set('n', '<leader>2',        '2gt',           {silent = true})
vim.keymap.set('n', '<leader>3',        '3gt',           {silent = true})
vim.keymap.set('n', '<leader>4',        '4gt',           {silent = true})
vim.keymap.set('n', '<leader>5',        '5gt',           {silent = true})
vim.keymap.set('n', '<leader>6',        '6gt',           {silent = true})
vim.keymap.set('n', '<leader>7',        '7gt',           {silent = true})
vim.keymap.set('n', '<leader>8',        '8gt',           {silent = true})
vim.keymap.set('n', '<leader>9',        '9gt',           {silent = true})
vim.keymap.set('n', '<leader>0',        '10gt',          {silent = true})

-- Move to brackets on double press
vim.keymap.set({'n', 'v'}, '{{', '[{')
vim.keymap.set({'n', 'v'}, '}}', ']}')
vim.keymap.set({'n', 'v'}, '((', '[(')
vim.keymap.set({'n', 'v'}, '))', '])')
