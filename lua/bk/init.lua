local bk_core = require("bk.core")
local bk_config = require("bk.config")

local M = {}

function M.setup(opt)
	local config = bk_config:merge_options(opt)
	vim.keymap.set("n", "<leader>pb", function()
		bk_core.bk(config.window.size, config.window.position)
	end, { desc = "Open epub reader" })
end

return M
