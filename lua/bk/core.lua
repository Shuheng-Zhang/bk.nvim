local bk_window = require("bk.window")
local bk_recent = vim.fn.stdpath("data") .. "/bk_recent"

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
end

function M.prepare_recent()
	local file_handle, err = io.open(bk_recent, "a+")
	if err then
		vim.notify("BK_RECENT_ERR: " .. err, vim.log.levels.ERROR)
		return
	end
	if file_handle then
		file_handle:close()
	end
end

function M.list_recent()
	local recent_list = {}
	local file_handle, err = io.open(bk_recent, "r")
	if err then
		vim.notify("BK_RECENT_ERR: " .. err, vim.log.levels.ERROR)
		return recent_list, err
	end

	if file_handle then
		local contents = file_handle:read("*a")
		file_handle:close()

		if contents then
			for line in contents:gmatch("[^\r\n]+") do
				table.insert(recent_list, line)
			end
		end
	end

	return recent_list
end

function M.add_recent(epub_path)
	local file_handle, r_err = io.open(bk_recent, "a+")
	if r_err then
		vim.notify("BK_RECENT_ERR: " .. r_err, vim.log.levels.ERROR)
		return
	end
	if file_handle then
		local _, w_err = file_handle:write(epub_path .. "\n")
		if r_err then
			vim.notify("BK_RECENT_ERR: " .. w_err, vim.log.levels.ERROR)
			file_handle:close()
			return
		end
		file_handle:flush()
		file_handle:close()
	end
end

function M.clear_recent()
	local file_handle, err = io.open(bk_recent, "w")
	if err then
		vim.notify("BK_RECENT_ERR: " .. err, vim.log.levels.ERROR)
		return
	end

	if file_handle then
		file_handle:write()
		file_handle:flush()
		file_handle:close()
		vim.notify("BK_RECENT: Cleared recently read files")
	end
end

return M
