-- set mode hl
(function()
	for key, val in pairs(require("yasl.highlights").mode) do
		vim.api.nvim_set_hl(0, "Yasl" .. key, val)
	end
end)()

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

return {
	events = { "WinEnter", "BufEnter", "ModeChanged" },
	update = function()
		local mode = mode_alias[vim.fn.mode()]
		return string.format("%%#Yasl%s# %s %%*", mode, mode)
	end
}
