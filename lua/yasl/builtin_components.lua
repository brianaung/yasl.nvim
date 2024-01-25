return {
	["diagnostics"] = {
		name = "diagnostics",
		events = { "LspAttach", "DiagnosticChanged" },
		update = function()
			local ret = ""
			local clients = vim.lsp.get_active_clients { buffer = 0 }
			if #clients == 0 or (#clients == 1 and clients[1].name == "copilot") then
				ret = ""
			else
				local errors = string.format("E%s", #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }))
				local warnings = string.format("W%s", #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }))
				ret = string.format("[%s,%s]", errors, warnings)
			end
			return ret
		end
	}
}
