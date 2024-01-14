local bg = require("yasl.highlights").fallback_bg
local accent = require("yasl.highlights").fallback_accent

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
