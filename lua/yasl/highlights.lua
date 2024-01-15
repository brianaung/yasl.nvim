local M = {}

M.fallback_bg = vim.api.nvim_get_hl(0, { name = "StatusLine" })
M.fallback_accent = vim.api.nvim_get_hl(0, { name = "PmenuSel" })

function M.set_section_hl(section_name, highlight, status_str)
	local hl_name = "YaslSection" .. section_name

	local fallback_color = M.fallback_bg
	if section_name == "A" or section_name == "E" then
		fallback_color = M.fallback_accent
	end

	vim.api.nvim_set_hl(0, hl_name, vim.F.if_nil(highlight, fallback_color))

	return string.format("%s%s%s%s %s", "%#", hl_name, "#", status_str, "%*")
end

return M
