local M = {}

function M.diagnostics()
	local ret = ""
	local clients = vim.lsp.get_active_clients { buffer = 0 }
	if #clients == 0 or (#clients == 1 and clients[1].name == "copilot") then
		-- ret = "LSP: off"
		ret = ""
	else
		local errors = string.format("E%s", #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }))
		local warnings = string.format("W%s", #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }))
		ret = string.format("[LSP: %s,%s]", errors, warnings)
	end
	return ret
end

return M
