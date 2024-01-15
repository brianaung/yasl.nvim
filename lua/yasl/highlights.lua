local M = {}

M.fallback_bg = vim.api.nvim_get_hl(0, { name = "StatusLine" })
M.fallback_accent = vim.api.nvim_get_hl(0, { name = "PmenuSel" })

function M.set_section_hl(grp, highlight)
	local name = "YaslSection" .. grp

	local fallback_color = M.fallback_bg
	if grp == "A" or grp == "E" then
		fallback_color = M.fallback_accent
	end

	vim.api.nvim_set_hl(0, name, vim.F.if_nil(highlight, fallback_color))
end

return M
