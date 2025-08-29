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

function M.init_cmd(config)
	vim.api.nvim_create_user_command("BkReader", function(opts)
		if #opts.fargs == 0 then
			-- require("bk.core").bk(config.window.size, config.window.position)
			vim.notify("no ePub file path", vim.log.levels.ERROR)
		else
			local epub_path = vim.fn.expand(opts.fargs[1])
			core.bk(config.window.size, config.window.position, epub_path)
			if config.recent then
				handle_recent(epub_path)
			end
		end
	end, { nargs = "*", complete = "file", desc = "Open ePub reader" })
end

return M
