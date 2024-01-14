local M = {}

local fallback_color = vim.api.nvim_get_hl(0, { name = "StatusLine" })

function M.set_hl(name, highlight)
	vim.api.nvim_set_hl(0, name, vim.F.if_nil(highlight, fallback_color))
end

return M
