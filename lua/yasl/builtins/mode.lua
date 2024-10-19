local CTRL_S = vim.keycode("<C-S>")
local CTRL_V = vim.keycode("<C-V>")

local modes = setmetatable({
	["n"] = { display = "NORMAL", hl = "YaslModeNormal" },
	["no"] = { display = "OP", hl = "YaslModeOther" },
	["nov"] = { display = "OP", hl = "YaslModeOther" },
	["noV"] = { display = "OP", hl = "YaslModeOther" },
	["no" .. CTRL_V] = { display = "OP", hl = "YaslModeOther" },
	["niI"] = { display = "NORMAL", hl = "YaslModeNormal" },
	["niR"] = { display = "NORMAL", hl = "YaslModeNormal" },
	["niV"] = { display = "NORMAL", hl = "YaslModeNormal" },
	["nt"] = { display = "NORMAL", hl = "YaslModeNormal" },
	["ntT"] = { display = "NORMAL", hl = "YaslModeNormal" },
	["v"] = { display = "VISUAL", hl = "YaslModeVisual" },
	["vs"] = { display = "VISUAL", hl = "YaslModeVisual" },
	["V"] = { display = "V-LINE", hl = "YaslModeVisual" },
	["Vs"] = { display = "V-LINE", hl = "YaslModeVisual" },
	[CTRL_V] = { display = "V-BLOCK", hl = "YaslModeVisual" },
	[CTRL_V .. "s"] = { display = "V-BLOCK", hl = "YaslModeVisual" },
	["s"] = { display = "SELECT", hl = "YaslModeVisual" },
	["S"] = { display = "S-LINE", hl = "YaslModeVisual" },
	[CTRL_S] = { display = "S-BLOCK", hl = "YaslModeVisual" },
	["i"] = { display = "INSERT", hl = "YaslModeInsert" },
	["ic"] = { display = "INSERT", hl = "YaslModeInsert" },
	["ix"] = { display = "INSERT", hl = "YaslModeInsert" },
	["R"] = { display = "REPLACE", hl = "YaslModeReplace" },
	["Rc"] = { display = "REPLACE", hl = "YaslModeReplace" },
	["Rx"] = { display = "REPLACE", hl = "YaslModeReplace" },
	["Rv"] = { display = "V-REPLACE", hl = "YaslModeReplace" },
	["Rvc"] = { display = "V-REPLACE", hl = "YaslModeReplace" },
	["Rvx"] = { display = "V-REPLACE", hl = "YaslModeReplace" },
	["c"] = { display = "COMMAND", hl = "YaslModeCommand" },
	["cr"] = { display = "COMMAND", hl = "YaslModeCommand" },
	["cv"] = { display = "EX", hl = "YaslModeCommand" },
	["cvr"] = { display = "EX", hl = "YaslModeCommand" },
	["r"] = { display = "ENTER", hl = "YaslModeOther" },
	["rm"] = { display = "MORE", hl = "YaslModeOther" },
	["r?"] = { display = "CONFIRM", hl = "YaslModeOther" },
	["!"] = { display = "SHELL", hl = "YaslModeOther" },
	["t"] = { display = "TERM", hl = "YaslModeTerm" },
}, {
	__index = function(_, key)
		return { display = key, hl = "YaslModeOther" }
	end,
})

vim.api.nvim_set_hl(0, "YaslModeNormal", { link = "DiffChange", default = true })
vim.api.nvim_set_hl(0, "YaslModeInsert", { link = "DiffAdd", default = true })
vim.api.nvim_set_hl(0, "YaslModeVisual", { link = "Visual", default = true })
vim.api.nvim_set_hl(0, "YaslModeReplace", { link = "DiffDelete", default = true })
vim.api.nvim_set_hl(0, "YaslModeCommand", { link = "Cursor", default = true })
vim.api.nvim_set_hl(0, "YaslModeTerm", { link = "CurSearch", default = true })
vim.api.nvim_set_hl(0, "YaslModeOther", { link = "IncSearch", default = true })

return {
	events = { "ModeChanged" },
	update = function()
		local mode_info = modes[vim.fn.mode()]
		return string.format("%%#%s# %s %%*", mode_info.hl, mode_info.display)
	end,
}
