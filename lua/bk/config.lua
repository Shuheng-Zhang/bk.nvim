local M = {
	default = {
		window = {
			width = 30,
			height = 24,
			-- float
			-- pined
			mode = "float",
			-- BL(Bottom Left)
			-- BR(Bottom Right)
			-- CENTER(float mode only)
			position = "BL",
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
