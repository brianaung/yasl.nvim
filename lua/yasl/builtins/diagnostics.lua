-- set diagnostic hl
(function()
	for key, val in pairs(require("yasl.highlights").diagnostic) do
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
