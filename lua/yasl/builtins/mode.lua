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
	events = { "BufEnter", "ModeChanged" },
	update = function()
		return "[" .. mode_alias[vim.fn.mode()] .. "]"
	end
}
