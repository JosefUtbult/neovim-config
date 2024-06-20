vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set the timeout length between chained key presses
vim.o.timeoutlen = 800

-- Map jj to escape
vim.keymap.set('i', 'jj', '<Esc>')
-- Clear the search on <leader>h
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
-- Go to the end of the line with qq
vim.keymap.set('i', 'qq', '<C-O><End>')

-- Reverse lines in visual mode
vim.keymap.set('v', 't', ':!tac<CR>')

-- Tab behaviour
vim.keymap.set('n', '<leader><leader>', ':tabnext<CR>' )
vim.keymap.set('n', '<leader>n',        ':tabnew<CR>'  )
vim.keymap.set('n', '<leader>m',				':tabmove<CR>' )
vim.keymap.set('n', '<leader>c', 			  ':tabclose<CR>')
vim.keymap.set('n', '<leader>o', 			  ':tabonly<CR>' )
vim.keymap.set('n', '<leader>1',        '1gt'          )
vim.keymap.set('n', '<leader>2',        '2gt'          )
vim.keymap.set('n', '<leader>3',        '3gt'          )
vim.keymap.set('n', '<leader>4',        '4gt'          )
vim.keymap.set('n', '<leader>5',        '5gt'          )
vim.keymap.set('n', '<leader>6',        '6gt'          )
vim.keymap.set('n', '<leader>7',        '7gt'          )
vim.keymap.set('n', '<leader>8',        '8gt'          )
vim.keymap.set('n', '<leader>9',        '9gt'          )
vim.keymap.set('n', '<leader>0',        '10gt'         )

-- Move to brackets on double press
vim.keymap.set({'n', 'v'}, '{{', '[{')
vim.keymap.set({'n', 'v'}, '}}', ']}')
vim.keymap.set({'n', 'v'}, '((', '[(')
vim.keymap.set({'n', 'v'}, '))', '])')
