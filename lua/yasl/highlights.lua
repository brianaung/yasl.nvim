local fallback_color = vim.api.nvim_get_hl(0, { name = "StatusLine" })

local M = {}

function M.set_group_hl(grp, highlight)
	local name = "YaslGroup" .. string.upper(grp)
	vim.api.nvim_set_hl(0, name, vim.F.if_nil(highlight, fallback_color))
end

return M
