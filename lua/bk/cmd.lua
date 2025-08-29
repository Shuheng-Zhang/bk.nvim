local M = {}

function M.init_cmd(config)
	vim.api.nvim_create_user_command("BkReader", function(opts)
		if #opts.fargs == 0 then
			require("bk.core").bk(config.window.size, config.window.position)
		else
			local epub_path = vim.fn.expand(opts.fargs[1])
			require("bk.core").bk(config.window.size, config.window.position, epub_path)
		end
	end, { nargs = "*", complete = "file", desc = "Open ePub reader" })
end

return M
