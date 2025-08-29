local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local bk_core = require("bk.core")
local bk_cmd = require("bk.cmd")

return function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "BK RECENT",
			finder = finders.new_table({
				results = bk_core.list_recent(),
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry,
						ordinal = entry,
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					bk_cmd.open_bk(selection.value)
					vim.cmd("startinsert")
				end)
				return true
			end,
		})
		:find()
end
