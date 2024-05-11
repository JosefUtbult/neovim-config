require('mkdnflow').setup({
	perspective = {
		-- priority = 'root',
		-- fallback = 'first',
		-- root_tell = '.obsidian'
	},
	mappings = {
		MkdnEnter = {{'n', 'v'}, '<CR>'},
		MkdnTab = false,
		MkdnSTab = false,
		MkdnNextLink = {'n', '<Tab>'},
		MkdnPrevLink = {'n', '<S-Tab>'},
		MkdnNextHeading = {'n', ']]'},
		MkdnPrevHeading = {'n', '[['},
		MkdnGoBack = {'n', '<BS>'},
		MkdnGoForward = {'n', '<Del>'},
		MkdnCreateLink = false, -- see MkdnEnter
		MkdnCreateLinkFromClipboard = {{'n', 'v'}, '<leader>p'}, -- see MkdnEnter
		MkdnFollowLink = false, -- see MkdnEnter
		MkdnDestroyLink = {'n', '<M-CR>'},
		MkdnTagSpan = {'v', '<M-CR>'},
		MkdnMoveSource = {'n', '<F2>'},
		MkdnYankAnchorLink = {'n', 'yaa'},
		MkdnYankFileAnchorLink = {'n', 'yfa'},
		MkdnIncreaseHeading = {'n', '+'},
		MkdnDecreaseHeading = {'n', '-'},
		MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
		MkdnNewListItem = false,
		MkdnNewListItemBelowInsert = {'n', 'o'},
		MkdnNewListItemAboveInsert = {'n', 'O'},
		MkdnExtendList = false,
		MkdnUpdateNumbering = {'n', '<leader>nn'},
		MkdnTableNextCell = {'i', '<Tab>'},
		MkdnTablePrevCell = {'i', '<S-Tab>'},
		MkdnTableNextRow = false,
		MkdnTablePrevRow = {'i', '<M-CR>'},
		MkdnTableNewRowBelow = {'n', '<leader>ir'},
		MkdnTableNewRowAbove = {'n', '<leader>iR'},
		MkdnTableNewColAfter = {'n', '<leader>ic'},
		MkdnTableNewColBefore = {'n', '<leader>iC'},
		MkdnFoldSection = {'n', '<leader>f'},
		MkdnUnfoldSection = {'n', '<leader>F'}
	}
})
