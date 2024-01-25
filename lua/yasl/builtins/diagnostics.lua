-- set diagnostic hl
(function()
	local diagnostic_hl = {
		["Error"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg, "red"),
			bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
		},
		["Warn"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg, "yellow"),
			bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
		},
		["Info"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }).fg, "blue"),
			bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
		},
		["Hint"] = {
			fg = vim.F.if_nil(vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }).fg, "cyan"),
			bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
		},
	}

	for key, val in pairs(diagnostic_hl) do
		vim.api.nvim_set_hl(0, "Yasl" .. key, val)
	end
end)()

return {
	events = { "LspAttach", "DiagnosticChanged" },
	update = function()
		local clients = vim.lsp.get_active_clients { buffer = 0 }

		if #clients == 0 or (#clients == 1 and clients[1].name == "copilot") then return "" end

		local error, warn, info, hint = "", "", "", ""
		local e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		if e > 0 then
			error = string.format("%%#YaslError#E%s%%* ", e)
		end
		local w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		if w > 0 then
			warn = string.format("%%#YaslWarn#W%s%%* ", w)
		end
		local i = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		if i > 0 then
			info = string.format("%%#YaslInfo#I%s%%* ", i)
		end
		local h = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		if h > 0 then
			hint = string.format("%%#YaslHint#H%s%%*", h)
		end

		return string.format("%s%s%s%s", error, warn, info, hint)
	end
}
