local M = {
	default = {
		window = {
			size = {
				width = 80,
				height = 5,
			},
			position = "BOTTOM_RIGHT",
		},
		recent = true,
	},
}

function M:merge_options(opts)
	if type(opts) == "table" and opts ~= {} then
		self.default = vim.tbl_deep_extend("force", self.default, opts)
	end

	return self.default
end

return M
