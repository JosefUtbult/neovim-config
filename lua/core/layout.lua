local api = vim.api

local is_active_per_tab = {}

local max_columns = 200

local function get_tab_suffix()
	return tostring(api.nvim_get_current_tabpage())
end

local function find_buffer_by_name(name)
	for _, bufnr in ipairs(api.nvim_list_bufs()) do
		if api.nvim_buf_is_loaded(bufnr) then
			local bufname = api.nvim_buf_get_name(bufnr)
			if bufname:match(name) then
				return bufnr
			end
		end
	end
	return nil
end

local function find_window_for_buffer(bufnr)
	for _, win in ipairs(api.nvim_list_wins()) do
		if api.nvim_win_get_buf(win) == bufnr then
			return win
		end
	end
	return nil
end

local function reset_buffer(bufnr, win)
	api.nvim_buf_set_option(bufnr, "modifiable", true)
	api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
	api.nvim_buf_set_option(bufnr, "modifiable", false)

	api.nvim_buf_set_option(bufnr, "buftype", "nofile")
	api.nvim_buf_set_option(bufnr, "bufhidden", "hide")
	api.nvim_buf_set_option(bufnr, "swapfile", false)

	api.nvim_set_option_value("winfixwidth", true, { win = win })

	api.nvim_win_set_cursor(win, { 1, 0 })
end

local function is_over_max()
	return vim.o.columns > max_columns
end

local function get_pad_size()
	return (vim.o.columns - max_columns) / 2
end

local function reset_left_buffer()
	if not is_over_max() then
		return
	end

	local tab = get_tab_suffix()
	local main_win = api.nvim_get_current_win()
	local bufnr = find_buffer_by_name("pad%-left%-" .. tab .. "$")
	local win
	local pad_size = get_pad_size()

	if bufnr then
		win = find_window_for_buffer(bufnr)
		if not win then
			vim.cmd("leftabove " .. pad_size .. "vnew")
			win = api.nvim_get_current_win()
			api.nvim_win_set_buf(win, bufnr)
		else
			api.nvim_set_current_win(win)
		end
	else
		vim.cmd("leftabove " .. pad_size .. "vnew")
		win = api.nvim_get_current_win()
		bufnr = api.nvim_get_current_buf()
		api.nvim_buf_set_name(bufnr, "pad-left-" .. tab)
	end

	reset_buffer(bufnr, win)
	api.nvim_set_current_win(main_win)
	is_active_per_tab[tab] = true
end

local function reset_right_buffer()
	if not is_over_max() then
		return
	end

	local tab = get_tab_suffix()
	local main_win = api.nvim_get_current_win()
	local bufnr = find_buffer_by_name("pad%-right%-" .. tab .. "$")
	local win
	local pad_size = get_pad_size()

	if bufnr then
		win = find_window_for_buffer(bufnr)
		if not win then
			vim.cmd("rightbelow " .. pad_size .. "vnew")
			win = api.nvim_get_current_win()
			api.nvim_win_set_buf(win, bufnr)
		else
			api.nvim_set_current_win(win)
		end
	else
		vim.cmd("rightbelow " .. pad_size .. "vnew")
		win = api.nvim_get_current_win()
		bufnr = api.nvim_get_current_buf()
		api.nvim_buf_set_name(bufnr, "pad-right-" .. tab)
	end

	reset_buffer(bufnr, win)
	api.nvim_set_current_win(main_win)
	is_active_per_tab[tab] = true
end

local function open_side_buffers()
	reset_left_buffer()
	reset_right_buffer()
end

local function toggle_nvim_tree()
	local nvim_tree_api = require("nvim-tree.api")
	local tab = get_tab_suffix()

	if nvim_tree_api.tree.is_visible() then
		nvim_tree_api.tree.close()
	else
		if is_active_per_tab[tab] then
			for _, win in ipairs(api.nvim_list_wins()) do
				local buf = api.nvim_win_get_buf(win)
				local name = api.nvim_buf_get_name(buf)
				if name:match("pad%-left%-" .. tab .. "$") then
					nvim_tree_api.tree.open({
						winid = win,
						width = "100%",
					})
					return
				end
			end
		end

		nvim_tree_api.tree.open()
	end
end

local function maybe_close_pads_in_tab(tabpage)
	if not api.nvim_tabpage_is_valid(tabpage) then
		return
	end

	local tab_key = tostring(tabpage)
	if not is_active_per_tab[tab_key] then
		return
	end

	local wins = api.nvim_tabpage_list_wins(tabpage)
	local pad_wins = {}
	local real_wins = {}

	for _, win in ipairs(wins) do
		local buf = api.nvim_win_get_buf(win)
		local name = api.nvim_buf_get_name(buf)

		if name:match("pad%-left%-" .. tab_key .. "$") or name:match("pad%-right%-" .. tab_key .. "$") then
			pad_wins[#pad_wins + 1] = win
		elseif not name:match("^NvimTree_") then -- treat tree as real
			real_wins[#real_wins + 1] = win
		end
	end

	if #real_wins == 0 then
		-- We are about to remove the last real window in this tab
		local total_tabs = vim.fn.tabpagenr("$")

		if total_tabs > 1 then
			-- Close only this tab (switch to it first so :tabclose works)
			api.nvim_set_current_tabpage(tabpage)
			vim.cmd("tabclose!")
		else
			-- Last tab → quit Neovim
			vim.cmd("qa!")
		end
		return
	end

	-- Otherwise just close the pad windows in this tab
	for _, win in ipairs(pad_wins) do
		if api.nvim_win_is_valid(win) then
			api.nvim_win_close(win, true)
		end
	end
	is_active_per_tab[tab_key] = nil
end

api.nvim_create_user_command("ResetLayout", function()
	open_side_buffers()
end, {})

vim.keymap.set("n", "<C-n>", toggle_nvim_tree, { noremap = true, silent = true })

api.nvim_create_autocmd("TabEnter", {
	callback = function()
		local tab = get_tab_suffix()
		if not is_active_per_tab[tab] then
			vim.schedule(open_side_buffers)
		end
	end,
})

api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.schedule(open_side_buffers)
	end,
})

vim.api.nvim_create_autocmd("WinClosed", {
	callback = function(args)
		local closed_win = tonumber(args.match)
		if closed_win then
			local buf = vim.api.nvim_win_get_buf(closed_win)
			local bufname = vim.api.nvim_buf_get_name(buf)
			if bufname:match("NvimTree_") then
				-- Reset left buffer for current tab only
				local tab = get_tab_suffix()
				if is_active_per_tab[tab] then
					reset_left_buffer()
				end
			end
		end
	end,
})

api.nvim_create_autocmd("WinClosed", {
	callback = function(args)
		local closing_win = tonumber(args.match)
		if not closing_win or not api.nvim_win_is_valid(closing_win) then
			return
		end

		if api.nvim_win_get_config(closing_win).relative ~= "" then
			return
		end

		local tabpage = api.nvim_win_get_tabpage(closing_win)
		vim.schedule(function()
			maybe_close_pads_in_tab(tabpage)
		end)
	end,
})
