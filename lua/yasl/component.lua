local M = {}

M.components = {
	["mode"] = "%{mode()}",
	["filename"] = "%<%t%h%m%r%w",
	["branch"] = "%{luaeval('branch()')}",
	["gitdiff"] = "%{luaeval('gitdiff()')}",
	["diagnostics"] = "%{luaeval('diagnostics()')}",
	["filetype"] = "%y",
	["progress"] = "%P",
	["location"] = "%-8.(%l, %c%V%)",
}

-- some component can have empty content, in which case we don't want to show the bg
function M.is_component_empty(component)
	if component == "filetype" and #vim.fn.expand("%") == 0 then
		return true
	end
	if component == "diagnostics" and diagnostics() == "" then
		return true
	end
	return false
end

return M
