return {
	events = { "WinEnter", "BufEnter", "LspAttach", "LspDetach", "DiagnosticChanged" },
	update = function()
		local bufnr = vim.api.nvim_get_current_buf()

		local diagnostic_strlist = {}

		local error = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
		if error > 0 then
			table.insert(diagnostic_strlist, "E" .. error)
		end

		local warn = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
		if warn > 0 then
			table.insert(diagnostic_strlist, "W" .. warn)
		end

		local info = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })
		if info > 0 then
			table.insert(diagnostic_strlist, "I" .. info)
		end

		local hint = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })
		if hint > 0 then
			table.insert(diagnostic_strlist, "H" .. hint)
		end

		return string.format(" %s ", table.concat(diagnostic_strlist, ","))
	end,
}
