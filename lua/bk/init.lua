local bk_config = require("bk.config")
local bk_core = require("bk.core")
local cmd = require("bk.cmd")

local M = {}

function M.setup(opt)
	local config = bk_config:merge_options(opt)
	if config.recent then
		bk_core.prepare_recent()
	end
	cmd.init_cmd(config)

	local ok, m_telescope = pcall(require, "telescope")
	if ok then
		m_telescope.load_extension("bk_telescope")
	end
end

return M
