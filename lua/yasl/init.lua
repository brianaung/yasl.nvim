local builtins = require("yasl.builtins")
local default = require("yasl.default")

local status_strings = {}

local function set_statusline(str)
	vim.api.nvim_win_set_option(0, "statusline", table.concat(str))
end

local function create_update_group(key, component)
	local update = component.update
	status_strings[key] = update()
	vim.api.nvim_create_autocmd(component.events, {
		callback = function()
			local new = update()
			if status_strings[key] ~= new then
				status_strings[key] = new
				set_statusline(status_strings)
			end
		end
	})
end

local M = {}

function M.setup(opts)
	opts = vim.F.if_nil(opts, default)

	-- opts.global
	local global = vim.F.if_nil(opts.global, default.global)
	vim.api.nvim_set_option("laststatus", global and 3 or 2)

	-- opts.components
	local components = vim.F.if_nil(opts.components, default.components)

	for idx, component in ipairs(components) do
		if type(component) == "table" then
			create_update_group(idx, component)
		elseif type(component) == "string" and builtins[component] ~= nil then
			create_update_group(idx, builtins[component])
		elseif type(component) == "string" then
			status_strings[idx] = component
		end
	end
	vim.api.nvim_set_option("showmode", false)

	-- Default events to refresh statusline
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			set_statusline(status_strings)
		end
	})
	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.api.nvim_win_set_option(0, "statusline", "")
		end
	})
end

return M
