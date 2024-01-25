local bg = require("yasl.highlights").fallback_bg
local accent = vim.api.nvim_get_hl(0, { name = "PmenuSel" })

return {
	global = true,

	sections = {
		A = { components = { "mode" }, highlight = accent },
		B = { components = { "diagnostics" }, highlight = bg },
		C = { components = { "filename", "branch", "gitdiff" }, highlight = bg },
		D = { components = { "filetype" }, highlight = bg },
		E = { components = { "location", "progress" }, highlight = accent },
	}
}
