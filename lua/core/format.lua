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

-- Enable wrapping by default
vim.opt.wrap = true

-- Enable squiggly underlines
vim.diagnostic.config({ virtual_text = true })
vim.cmd.highlight('highlight-name gui=undercurl')

-- Set tab behaviour
if(os.getenv("CLAVIA") ~= nil) then
	-- On Clavia, indentation is always 2 spaces
	vim.opt.tabstop = 2
	vim.opt.softtabstop = 2
	vim.opt.shiftwidth = 2
else
	vim.opt.tabstop = 3
	vim.opt.softtabstop = 3
	vim.opt.shiftwidth = 3
end

-- Disable conceal level
vim.opt.conceallevel = 0
