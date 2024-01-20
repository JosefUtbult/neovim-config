-- Nvim-tree file browser

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

-- Map <C-n> to toggle NvimTree
vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>')
