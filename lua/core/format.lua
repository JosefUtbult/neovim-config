-- Layout format of documents
vim.opt.backspace = 'indent,eol,start'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = false
vim.opt.autoread = true

-- Use hybrid line numbering
vim.wo.relativenumber = true
vim.wo.number = true

-- Make search case in-sensitive, if not explicitly searching for upper case
-- letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Use smart indentation
vim.opt.smartindent = true

-- Set tab behaviour
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

