local split_lines = require("yasl.utils").split_lines
local process_diff = require("yasl.utils").process_diff

-- todo: how can i use these providers inside luaeval without making them global??
YaslProviders = YaslProviders or {}

function YaslProviders.branch()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	if branch ~= "" then
		return string.format("[%s]", branch)
	else
		return ""
	end
end

function YaslProviders.diagnostics()
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

function YaslProviders.gitdiff()
	if #vim.fn.expand("%") == 0 then return "" end -- no opened buffer

	local raw_diff = vim.fn.system(string.format("git --no-pager diff --no-color --no-ext-diff -U0 -- %s",
		vim.fn.expand("%")))

	if #raw_diff == 0 then return "" end -- no diff stats

	local diff_stats = process_diff(split_lines(raw_diff))
	return string.format("[+%s,-%s,~%s]", diff_stats.added, diff_stats.removed, diff_stats.modified)
end
