local function split_lines(str)
	local lines = {}
	for s in str:gmatch("[^\r\n]+") do
		table.insert(lines, s)
	end
	return lines
end

-- Adapted from https://github.com/nvim-lualine/lualine.nvim
local function process_diff(data)
	local added, removed, modified = 0, 0, 0
	for _, line in ipairs(data) do
		if string.find(line, [[^@@ ]]) then
			local tokens = vim.fn.matchlist(line, [[^@@ -\v(\d+),?(\d*) \+(\d+),?(\d*)]])
			local line_stats = {
				mod_count = tokens[3] == nil and 0 or tokens[3] == "" and 1 or tonumber(tokens[3]),
				new_count = tokens[5] == nil and 0 or tokens[5] == "" and 1 or tonumber(tokens[5]),
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

return {
	events = { "WinEnter", "BufEnter", "BufWritePost" },
	update = function()
		local obj = vim.system({
			"git",
			"-C",
			vim.fn.expand("%:h"),
			"--no-pager",
			"diff",
			"--no-color",
			"--no-ext-diff",
			"-U0",
			"--",
			vim.fn.expand("%:t"),
		}, { text = true }):wait()

		local diff_strlist = {}

		local raw_diff = obj.stdout or ""
		local diff_stats = process_diff(split_lines(raw_diff))

		if diff_stats.added > 0 then
			table.insert(diff_strlist, "+" .. diff_stats.added)
		end
		if diff_stats.removed > 0 then
			table.insert(diff_strlist, "-" .. diff_stats.removed)
		end
		if diff_stats.modified > 0 then
			table.insert(diff_strlist, "~" .. diff_stats.modified)
		end

		return string.format(" %s ", table.concat(diff_strlist, ","))
	end,
}
