local component_types = require("yasl.component").component_types
local is_component_empty = require("yasl.component").is_component_empty
local set_section_hl = require("yasl.highlights").set_section_hl

local function get_section_status(section, grp_name)
	if section.components == nil or
			#section.components == 0 or
			(#section.components == 1 and is_component_empty(section.components[1])) then
		return ""
	end

	set_section_hl(grp_name, section.highlight)

	local curr = string.format("%s%s%s", "%#", "YaslGroup" .. grp_name, "#")
	for _, component in ipairs(section.components) do
		curr = string.format("%s %s", curr, component_types[component])
	end
	return string.format("%s %s", curr, "%*")
end

local M = {}

function M.set_statusline(sections)
	vim.api.nvim_win_set_option(0, "statusline", table.concat({
		get_section_status(vim.F.if_nil(sections.a, {}), "a"),
		get_section_status(vim.F.if_nil(sections.b, {}), "b"),
		"%=",
		get_section_status(vim.F.if_nil(sections.c, {}), "c"),
		"%=",
		get_section_status(vim.F.if_nil(sections.d, {}), "d"),
		get_section_status(vim.F.if_nil(sections.e, {}), "e")
	}))
end

return M
