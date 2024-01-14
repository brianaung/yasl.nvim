require("yasl.providers")

local M = {}

M.component_types = {
	["mode"] = "%{luaeval('YaslProviders.mode()')}",
	["filename"] = "%<%t%h%m%r%w",
	["branch"] = "%{luaeval('YaslProviders.branch()')}",
	["gitdiff"] = "%{luaeval('YaslProviders.gitdiff()')}",
	["diagnostics"] = "%{luaeval('YaslProviders.diagnostics()')}",
	["filetype"] = "%y",
	["progress"] = "%P",
	["location"] = "%-8.(%l, %c%V%)",
}

-- some component can have empty content, in which case we don't want to show the bg
function M.is_component_empty(component)
	if component == "filetype" and #vim.fn.expand("%") == 0 then
		return true
	end
	if component == "diagnostics" and YaslProviders.diagnostics() == "" then
		return true
	end
	return false
end

return M
