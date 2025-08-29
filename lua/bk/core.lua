local bk_window = require("bk.window")

BK_BUFFER = -1
BK_OPENED = false
BK_WINDOW = -1

local function on_exit(job_id, code, event)
	if code ~= 0 then
		return
	end

	if vim.api.nvim_win_is_valid(BK_WINDOW) then
		vim.api.nvim_win_close(BK_WINDOW, true)
		BK_WINDOW = -1
	end

	if vim.api.nvim_buf_is_valid(BK_BUFFER) and vim.api.nvim_buf_is_loaded(BK_BUFFER) then
		vim.api.nvim_buf_delete(BK_BUFFER, { force = true })
	end

	BK_BUFFER = -1
	BK_OPENED = false
end

local M = {}

function M.bk(win_range_size, win_position, epub_path)
	bk_window.open_bk_win(win_range_size, win_position)

	local cmd = { "bk" }
	if epub_path and epub_path ~= "" then
		table.insert(cmd, epub_path)
	end

	vim.schedule(function()
		vim.fn.jobstart(cmd, { term = true, on_exit = on_exit })
	end)
	vim.cmd("startinsert")
end

return M
