-- Disable auto reading of file-changes when editing on files from the network drive
vim.api.nvim_create_autocmd({"BufRead", "BufWrite"}, {
	pattern = { "/mnt/josefs-p358/**" },
	command = "setlocal noautoread"
})
