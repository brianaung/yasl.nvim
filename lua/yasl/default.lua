local bg = require("yasl.highlights").fallback_bg
local accent = require("yasl.highlights").fallback_accent

return {
	global = true,

	sections = {
		a = { components = { "mode" }, highlight = accent },
		b = { components = { "diagnostics" }, highlight = bg },
		c = { components = { "filename", "branch", "gitdiff" }, highlight = bg },
		d = { components = { "filetype" }, highlight = bg },
		e = { components = { "location", "progress" }, highlight = accent },
	}
}
