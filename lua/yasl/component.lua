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
	-- Adapted from https://github.com/nvim-lualine/lualine.nvim
	local function process_diff(data)
		local added, removed, modified = 0, 0, 0
		for _, line in ipairs(data) do
			if string.find(line, [[^@@ ]]) then
				local tokens = vim.fn.matchlist(line, [[^@@ -\v(\d+),?(\d*) \+(\d+),?(\d*)]])
				local line_stats = {
					mod_count = tokens[3] == nil and 0 or tokens[3] == '' and 1 or tonumber(tokens[3]),
					new_count = tokens[5] == nil and 0 or tokens[5] == '' and 1 or tonumber(tokens[5]),
				}

				if line_stats.mod_count == 0 and line_stats.new_count > 0 then
					added = added + line_stats.new_count
				elseif line_stats.mod_count > 0 and line_stats.new_count == 0 then
					removed = removed + line_stats.mod_count
				else
					local min = math.min(line_stats.mod_count, line_stats.new_count)
					modified = modified + min
					added = added + line_stats.new_count - min
					removed = removed + line_stats.mod_count - min
				end
			end
		end
		return { added = added, modified = modified, removed = removed }
	end

	local function split_lines(str)
		local lines = {}
		for s in str:gmatch("[^\r\n]+") do
			table.insert(lines, s)
		end
		return lines
	end

	-- no opened buffer
	if #vim.fn.expand("%") == 0 then return "" end

	local raw_diff = vim.fn.system(string.format("git --no-pager diff --no-color --no-ext-diff -U0 -- %s",
		vim.fn.expand("%")))

	-- no diff stats
	if #raw_diff == 0 then return "" end

	local diff_stats = process_diff(split_lines(raw_diff))

	return string.format("[+%s,-%s,~%s]", diff_stats.added, diff_stats.removed, diff_stats.modified)
end

return M
