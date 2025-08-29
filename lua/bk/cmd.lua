local core = require("bk.core")
local M = {}

local function handle_recent(epub_path)
	local recent, err = core.list_recent()
	if err then
		return
	end

	local is_existed = false
	for _, r in ipairs(recent) do
		if r == epub_path then
			is_existed = true
			break
		end
	end
	if not is_existed then
		core.add_recent(epub_path)
	end
end

local function open_bk(epub_path)
	if not epub_path or "" == epub_path then
		vim.notify("no ePub file path", vim.log.levels.ERROR)
		return
	end

	core.bk(M.config.window.size, M.config.window.position, epub_path)
	if M.config.recent then
		handle_recent(epub_path)
	end
end

local function clear_recent()
	if M.config.recent then
		core.clear_recent()
	end
end

function M.init_cmd(config)
	M.config = config
	M.open_bk = open_bk
	M.clear_recent = clear_recent

	vim.api.nvim_create_user_command("BkReader", function(opts)
		if #opts.fargs == 0 then
			vim.notify("no ePub file path", vim.log.levels.ERROR)
		else
			local epub_path = vim.fn.expand(opts.fargs[1])
			open_bk(epub_path)
			vim.cmd("startinsert")
		end
	end, { nargs = "*", complete = "file", desc = "Open ePub reader" })

	vim.api.nvim_create_user_command("BkRecentClear", function()
		clear_recent()
	end, { desc = "Clear recently read file" })
end

return M
