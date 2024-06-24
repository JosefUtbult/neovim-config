return {
	{
		"kiyoon/jupynium.nvim",
		requirements = {
			"stevearc/dressing.nvim"
		},
		-- enabled = false,
		keys = {
			{
				"<leader>ja",
				":JupyniumStartAndAttachToServer<CR>",
				desc = "Start and attach to Jupyter server"
			},
			{
				"<leader>js",
				":JupyniumStartSync<CR>",
				desc = "Start synch to attached Jupyter server"
			},
			{
				"<leader>jx",
				":JupyniumExecuteSelectedCells<CR>",
				desc = "Execute the current Jupyter cell"
			},
			{
				"<leader>jc",
				":JupyniumClearSelectedCellsOutputs<CR>",
				desc = "Clear the current Jupyter cell"
			},
			{
				"<leader>jd",
				":JupyniumDownloadIpynb<CR>",
				desc = "Download the current Jupyter file"
			},
			{
				"<leader>jp",
				":call append('.', '# %%')<CR>jo",
				desc = "Add a python cell"
			},
			{
				"<leader>jm",
				":call append('.', '# %% [md]')<CR>j:call append('.', '\"\"\"')<CR>j:call append('.', '\"\"\"')<CR>o",
				desc = "Add a markdown cell"
			},
		},
		build = "\
			if [[ -f \"/etc/os-release\" && \"$(cat /etc/os-release | sed -E 's/^NAME=\"(.*)\"$/\1/gm;t;d')\" == \"Ubuntu\" ]]; then \
				pip3 install --user --break-system-packages notebook nbclassic jupyter-console jupyterthemes && \
				pip3 install --user --break-system-packages . && \
			else \
				pip3 install --user notebook nbclassic jupyter-console jupyterthemes && \
				pip3 install --user . && \
			fi \
			jt -t onedork",
		opts = {
			textobjects = {
				use_default_keybindings = false
			}
		}
	},
}
