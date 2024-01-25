local mode_alias = {
	['n'] = 'NORMAL',
	['no'] = 'OP',
	['nov'] = 'OP',
	['noV'] = 'OP',
	['no'] = 'OP',
	['niI'] = 'NORMAL',
	['niR'] = 'NORMAL',
	['niV'] = 'NORMAL',
	['v'] = 'VISUAL',
	['vs'] = 'VISUAL',
	['V'] = 'LINES',
	['Vs'] = 'LINES',
	[''] = 'BLOCK',
	['s'] = 'BLOCK',
	['s'] = 'SELECT',
	['S'] = 'SELECT',
	[''] = 'BLOCK',
	['i'] = 'INSERT',
	['ic'] = 'INSERT',
	['ix'] = 'INSERT',
	['R'] = 'REPLACE',
	['Rc'] = 'REPLACE',
	['Rv'] = 'V-REPLACE',
	['Rx'] = 'REPLACE',
	['c'] = 'COMMAND',
	['cv'] = 'COMMAND',
	['ce'] = 'COMMAND',
	['r'] = 'ENTER',
	['rm'] = 'MORE',
	['r?'] = 'CONFIRM',
	['!'] = 'SHELL',
	['t'] = 'TERM',
	['nt'] = 'TERM',
	['null'] = 'NONE',
}

-- Note: still experimental, kinda hacky
-- set_mode_hl
(function()
	local mode_hl = {
		["NORMAL"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "String" }).fg, "green"),
		},
		["OP"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "String" }).fg, "green"),
		},
		["INSERT"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).fg, "white"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Error" }).fg, "red"),
		},
		["VISUAL"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Function" }).fg, "skyblue"),
		},
		["LINES"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Function" }).fg, "skyblue"),
		},
		["BLOCK"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Function" }).fg, "skyblue"),
		},
		["REPLACE"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Keyword" }).fg, "violet"),
		},
		["V-REPLACE"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Keyword" }).fg, "violet"),
		},
		["ENTER"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Special" }).fg, "cyan"),
		},
		["MORE"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Special" }).fg, "cyan"),
		},
		["SELECT"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Constant" }).fg, "orange"),
		},
		["COMMAND"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Type" }).fg, "yellow"),
		},
		["SHELL"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "String" }).fg, "green"),
		},
		["TERM"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "String" }).fg, "green"),
		},
		["NONE"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Normal" }).bg, "black"),
			bg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "Type" }).fg, "yellow"),
		},
	}

	for key, val in pairs(mode_hl) do
		vim.api.nvim_set_hl(0, "Yasl" .. key, val)
	end
end)()

return {
	events = { "BufEnter", "ModeChanged" },
	update = function()
		local mode = mode_alias[vim.fn.mode()]
		return string.format("%%#Yasl%s# %s %%*", mode, mode)
	end
}
