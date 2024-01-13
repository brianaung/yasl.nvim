local M = {}

function M.branch()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	if branch ~= "" then
		return string.format("[%s]", branch)
	else
		return ""
	end
end

function M.diagnostics()
	local ret = ""
	local clients = vim.lsp.get_active_clients { buffer = 0 }
	if #clients == 0 or (#clients == 1 and clients[1].name == "copilot") then
		ret = ""
	else
		local errors = string.format("E%s", #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }))
		local warnings = string.format("W%s", #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }))
		ret = string.format("[LSP: %s,%s]", errors, warnings)
	end
	return ret
end

function M.gitdiff()
	-- no opened buffer
	if #vim.fn.expand("%") == 0 then return "" end

	local raw_stats = vim.fn.system("git diff --numstat " .. vim.fn.expand("%"))

	-- no diff stats
	if #raw_stats == 0 then return "" end

	-- helper to parse tabs separated values
	local function parse_tsv(s)
		local result = {}
		s = s .. '\t'
		for w in s:gmatch("(.-)\t") do
			table.insert(result, w)
		end
		return result
	end

	local diff_add = parse_tsv(raw_stats)[1]
	local diff_del = parse_tsv(raw_stats)[2]

	return string.format("[+%s,-%s]", diff_add, diff_del)
end

return M
