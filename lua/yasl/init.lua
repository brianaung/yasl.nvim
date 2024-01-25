local M = {}

local default = require("yasl.default")

function M.setup(opts)
	opts = vim.F.if_nil(opts, default)

	-- opts.global
	local global = vim.F.if_nil(opts.global, default.global)
	vim.api.nvim_set_option("laststatus", global and 3 or 2)

	-- opts.components
	local components = vim.F.if_nil(opts.components, default.components)

	vim.api.nvim_win_set_option(0, "statusline", table.concat(
		components
	))
end

return M
