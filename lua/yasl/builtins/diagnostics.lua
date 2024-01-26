-- set diagnostic hl
(function()
	for key, val in pairs(require("yasl.highlights").diagnostic) do
		vim.api.nvim_set_hl(0, "Yasl" .. key, val)
	end
end)()

local function get_diagnostic_count(severity)
	return #vim.diagnostic.get(0, { severity = severity })
end

return {
	events = { "WinEnter", "BufEnter", "LspAttach", "DiagnosticChanged" },
	update = function()
		local clients = vim.lsp.get_active_clients { buffer = 0 }

		if #clients == 0 or (#clients == 1 and clients[1].name == "copilot") then return "" end

		local error_count = get_diagnostic_count(vim.diagnostic.severity.ERROR)
		local error = error_count > 0 and string.format("%%#YaslError#E%s%%* ", error_count) or ""

		local warn_count = get_diagnostic_count(vim.diagnostic.severity.WARN)
		local warn = warn_count > 0 and string.format("%%#YaslWarn#W%s%%* ", warn_count) or ""

		local info_count = get_diagnostic_count(vim.diagnostic.severity.INFO)
		local info = info_count > 0 and string.format("%%#YaslInfo#I%s%%* ", info_count) or ""

		local hint_count = get_diagnostic_count(vim.diagnostic.severity.HINT)
		local hint = hint_count > 0 and string.format("%%#YaslHint#H%s%%*", hint_count) or ""

		return string.format("%s%s%s%s", error, warn, info, hint)
	end
}
