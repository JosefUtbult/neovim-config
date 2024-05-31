-- Download lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("core.keymap")
require("core.format")
require("core.spellcheck")
require("core.folding")
require("core.autoread")
require("core.commands")

-- require("vim-options")
require("lazy").setup("plugins")
