-- Note: colors are still experimental, kinda hacky
local if_nil = vim.F.if_nil
local function get_hl(name)
	return vim.api.nvim_get_hl(0, { name = name })
end

local green = {
	fg = if_nil(get_hl("Normal").bg, "black"),
	bg = if_nil(get_hl("String").fg, "green"),
}
local red = {
	fg = if_nil(get_hl("Normal").fg, "white"),
	bg = if_nil(get_hl("Error").fg, "red"),
}
local skyblue = {
	fg = if_nil(get_hl("Normal").bg, "black"),
	bg = if_nil(get_hl("Function").fg, "skyblue"),
}
local violet = {
	fg = if_nil(get_hl("Normal").bg, "black"),
	bg = if_nil(get_hl("Keyword").fg, "violet"),
}
local cyan = {
	fg = if_nil(get_hl("Normal").bg, "black"),
	bg = if_nil(get_hl("Special").fg, "cyan"),
}
local orange = {
	fg = if_nil(get_hl("Normal").bg, "black"),
	bg = if_nil(get_hl("Constant").fg, "orange"),
}
local yellow = {
	fg = if_nil(get_hl("Normal").bg, "black"),
	bg = if_nil(get_hl("Type").fg, "yellow"),
}

return {
	["mode"] = {
		["NORMAL"] = green,
		["OP"] = green,
		["INSERT"] = red,
		["VISUAL"] = skyblue,
		["LINES"] = skyblue,
		["BLOCK"] = skyblue,
		["REPLACE"] = violet,
		["V-REPLACE"] = violet,
		["ENTER"] = cyan,
		["MORE"] = cyan,
		["SELECT"] = orange,
		["COMMAND"] = yellow,
		["SHELL"] = green,
		["TERM"] = green,
		["NONE"] = yellow,
	},

	["diagnostic"] = {
		["Error"] = {
			fg = if_nil(get_hl("DiagnosticError").fg, "red"),
			bg = get_hl("StatusLine").bg,
		},
		["Warn"] = {
			fg = if_nil(get_hl("DiagnosticWarn").fg, "yellow"),
			bg = get_hl("StatusLine").bg,
		},
		["Info"] = {
			fg = if_nil(get_hl("DiagnosticInfo").fg, "blue"),
			bg = get_hl("StatusLine").bg,
		},
		["Hint"] = {
			fg = if_nil(get_hl("DiagnosticHint").fg, "cyan"),
			bg = get_hl("StatusLine").bg,
		},
	},

	["diff"] = {
		["Added"] = {
			fg = get_hl("DiffAdded").fg or get_hl("DiagnosticOk").fg or "green",
			bg = get_hl("StatusLine").bg,
		},
		["Removed"] = {
			fg = get_hl("DiffRemoved").fg or get_hl("DiagnosticError").fg or "red",
			bg = get_hl("StatusLine").bg,
		},
		["Modified"] = {
			fg = get_hl("DiffChanged").fg or get_hl("DiagnosticWarn").fg or "yellow",
			bg = get_hl("StatusLine").bg,
		},
	},
}
