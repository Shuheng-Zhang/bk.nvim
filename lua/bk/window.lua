local M = {}

local position = {
	BOTTOM_RIGHT = "BOTTOM_RIGHT",
	BOTTOM_LEFT = "BOTTOM_LEFT",
	BOTTOM_CENTER = "BOTTOM_CENTER",
}

local function get_win_pos(win_range_size, win_position)
	local parent_win = vim.api.nvim_list_uis()[1]

	local width = math.floor(parent_win.width * win_range_size)
	local height = math.floor(parent_win.height * win_range_size)

	local win_col = 0
	local win_row = 0
	if win_position == position.BOTTOM_RIGHT then
		win_col = parent_win.width - width - 1
		win_row = parent_win.height - height - 1
	elseif win_position == position.BOTTOM_LEFT then
		win_col = 1
		win_row = parent_win.height - height - 1
	elseif win_position == position.BOTTOM_CENTER then
		win_col = math.floor((parent_win.width - width) / 2)
		win_row = parent_win.height - height - 1
	else
		win_col = math.floor((parent_win.width - width) / 2)
		win_row = math.floor((parent_win.height - height) / 2)
	end

	return width, height, win_col, win_row
end

function M.open_bk_win(win_range_size, win_position)
	local width, height, col, row = get_win_pos(win_range_size, win_position)

	local opts = {
		style = "minimal",
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		border = "rounded",
	}

	if BK_BUFFER == nil or vim.fn.bufwinnr(BK_BUFFER) == -1 then
		BK_BUFFER = vim.api.nvim_create_buf(false, true)
	else
		BK_OPENED = true
	end

	BK_WINDOW = vim.api.nvim_open_win(BK_BUFFER, true, opts)

	vim.bo[BK_BUFFER].filetype = "term_bk"

	vim.bo.bufhidden = "hide"
	vim.wo.cursorcolumn = false
	vim.wo.signcolumn = "no"

	return BK_WINDOW, BK_BUFFER
end

return M
