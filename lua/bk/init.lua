local bk_config = require("bk.config")
local cmd = require("bk.cmd")

local M = {}

function M.setup(opt)
	local config = bk_config:merge_options(opt)
	cmd.init_cmd(config)
end

return M
