require("trouble").setup()

-- Trouble diagnostics toggle focus=false filter.buf=0
vim.keymap.set("n", "<leader>xx", "<CMD>Trouble diagnostics jump focus=false<CR>")
vim.keymap.set("n", "<leader>xs", "<CMD>Trouble symbols toggle focus=true<CR>")
vim.keymap.set("n", "<leader>xc", "<CMD>Trouble close<CR>")

-- Disable inline error text
vim.diagnostic.config({virtual_text=false})
