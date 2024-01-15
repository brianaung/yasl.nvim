local component_types = require("yasl.component").component_types
local is_component_empty = require("yasl.component").is_component_empty
local set_section_hl = require("yasl.highlights").set_section_hl

local function get_section_status(section, section_name)
	if section.components == nil or
			#section.components == 0 or
			(#section.components == 1 and is_component_empty(section.components[1])) then
		return ""
	end

	set_section_hl(section_name, section.highlight)

	local curr = string.format("%s%s%s", "%#", "YaslSection" .. section_name, "#")
	for _, component in ipairs(section.components) do
		if type(component) == "function" then
			-- custom component
			component = component()
		else
			-- provided component
			component = component_types[component]
		end
		curr = string.format("%s %s", curr, component)
	end
	return string.format("%s %s", curr, "%*")
end

local M = {}

function M.set_statusline(sections)
	vim.api.nvim_win_set_option(0, "statusline", table.concat({
		get_section_status(vim.F.if_nil(sections.A, {}), "A"),
		get_section_status(vim.F.if_nil(sections.B, {}), "B"),
		"%=",
		get_section_status(vim.F.if_nil(sections.C, {}), "C"),
		"%=",
		get_section_status(vim.F.if_nil(sections.D, {}), "D"),
		get_section_status(vim.F.if_nil(sections.E, {}), "E")
	}))
end

return M
