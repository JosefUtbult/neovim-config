-- Setup indent blank line

local highlight = {
    "Gray0",
    "Gray1",
	"Gray2",
    "Gray3",
    "Gray4",
    "Gray5",
    "Gray6",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Gray0", { fg = "#707070" })
    vim.api.nvim_set_hl(0, "Gray1", { fg = "#858585" })
    vim.api.nvim_set_hl(0, "Gray2", { fg = "#A0A0A0" })
    vim.api.nvim_set_hl(0, "Gray3", { fg = "#AAAAAA" })
    vim.api.nvim_set_hl(0, "Gray4", { fg = "#BBBBBB" })
    vim.api.nvim_set_hl(0, "Gray5", { fg = "#CCCCCC" })
	vim.api.nvim_set_hl(0, "Gray6", { fg = "#DDDDDD" })
end)

require("ibl").setup {
	indent = {
		-- Use our custom highlight colors
		highlight = highlight,
		-- Use the dotted character
		char="┊"
	}
}

