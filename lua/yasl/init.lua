Diagnostics = require("yasl.lib.diagnostics").diagnostics
Branch = require("yasl.lib.branch").branch

local M = {}

local get_statusgroup = function(section, hl_name)
	if section.components == nil or #section.components == 0 then return "" end
	-- define components
	local components = {
		["mode"] = "%{mode()}",
		["filename"] = "%<%t%h%m%r%w",
		["branch"] = "%{luaeval('Branch()')}",
		["diagnostics"] = "%{luaeval('Diagnostics()')}",
		["filetype"] = "%y",
		["progress"] = "%P",
		["location"] = "%-8.(%l, %c%V%)",
	}
	-- set highlight (or its fallback)
	vim.api.nvim_set_hl(0, hl_name,
		vim.F.if_nil(section.highlight, vim.api.nvim_get_hl(0, { name = "StatusLine" })))
	-- group components for current section
	local curr = string.format("%s%s%s", "%#", hl_name, "#")
	for i = 1, #section.components do
		if #vim.fn.expand("%") == 0 then
			curr = string.format("%s %s", curr, components[section.components[i]])
		end
	end
	return string.format("%s %s", curr, "%*")
end

M.setup = function(opts)
	vim.api.nvim_set_option("laststatus", 3)

	local default_groups = {
		["a"] = { components = { "mode" } },
		["b"] = { components = { "diagnostics" } },
		["c"] = { components = { "filename", "branch" } },
		["d"] = { components = { "filetype" } },
		["e"] = { components = { "location", "progress" } },
	}

	local status_string = ""
	if opts.sections ~= nil then
		status_string = string.format("%s%s %s %s %s %s%s",
			get_statusgroup(opts.sections.a, "a"),
			get_statusgroup(opts.sections.b, "b"),
			"%=",
			get_statusgroup(opts.sections.c, "c"),
			"%=",
			get_statusgroup(opts.sections.d, "d"),
			get_statusgroup(opts.sections.e, "e"))
	else
		status_string = string.format("%s%s %s %s %s %s%s",
			get_statusgroup(default_groups["a"], "a"),
			get_statusgroup(default_groups["b"], "b"),
			"%=",
			get_statusgroup(default_groups["c"], "c"),
			"%=",
			get_statusgroup(default_groups["d"], "d"),
			get_statusgroup(default_groups["e"], "e"))
	end
	vim.api.nvim_set_option("statusline", status_string)
end

return M
