-- Note: colors are still experimental, kinda hacky

local if_nil = vim.F.if_nil
local function get_hl(name)
	return vim.api.nvim_get_hl(0, { name = name })
end

return {
	["mode"] = {
		["NORMAL"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("String").fg, "green"),
		},
		["OP"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("String").fg, "green"),
		},
		["INSERT"] = {
			fg = if_nil(get_hl("Normal").fg, "white"),
			bg = if_nil(get_hl("Error").fg, "red"),
		},
		["VISUAL"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Function").fg, "skyblue"),
		},
		["LINES"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Function").fg, "skyblue"),
		},
		["BLOCK"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Function").fg, "skyblue"),
		},
		["REPLACE"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Keyword").fg, "violet"),
		},
		["V-REPLACE"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Keyword").fg, "violet"),
		},
		["ENTER"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Special").fg, "cyan"),
		},
		["MORE"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Special").fg, "cyan"),
		},
		["SELECT"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Constant").fg, "orange"),
		},
		["COMMAND"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Type").fg, "yellow"),
		},
		["SHELL"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("String").fg, "green"),
		},
		["TERM"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("String").fg, "green"),
		},
		["NONE"] = {
			fg = if_nil(get_hl("Normal").bg, "black"),
			bg = if_nil(get_hl("Type").fg, "yellow"),
		},
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
			fg = if_nil(get_hl("DiffAdded").fg, "red"),
			bg = get_hl("StatusLine").bg,
		},
		["Removed"] = {
			fg = if_nil(get_hl("DiffRemoved").fg, "yellow"),
			bg = get_hl("StatusLine").bg,
		},
		["Modified"] = {
			fg = if_nil(get_hl("DiffLine").fg, "cyan"),
			bg = get_hl("StatusLine").bg,
		},
	}
}
