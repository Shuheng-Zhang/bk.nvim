local M = {
	default = {
		window = {
			size = 0.4,
			position = "BOTTOM_RIGHT",
		},
	},
}

function M:merge_options(opts)
	if type(opts) == "table" and opts ~= {} then
		self.default = vim.tbl_deep_extend("force", self.default, opts)
	end

	return self.default
end

return M
