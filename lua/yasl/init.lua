local builtin_components = require("yasl.builtin_components")
local default = require("yasl.default")

local M = {}

function M.setup(opts)
	opts = vim.F.if_nil(opts, default)

	-- opts.global
	local global = vim.F.if_nil(opts.global, default.global)
	vim.api.nvim_set_option("laststatus", global and 3 or 2)

	-- opts.components
	local status_strs = {}
	local components = vim.F.if_nil(opts.components, default.components)

	local function set_statusline(str)
		vim.api.nvim_win_set_option(0, "statusline", table.concat(str))
	end

	local function create_update_group(key, component)
		local update = component.update
		status_strs[key] = update()
		vim.api.nvim_create_autocmd(component.events, {
			callback = function()
				status_strs[key] = update()
				set_statusline(status_strs)
			end
		})
	end

	for idx, component in ipairs(components) do
		if type(component) == "table" then
			create_update_group(idx, component)
		elseif type(component) == "string" and builtin_components[component] ~= nil then
			create_update_group(idx, builtin_components[component])
		elseif type(component) == "string" then
			status_strs[idx] = component
		end
	end

	set_statusline(status_strs)
end

return M
