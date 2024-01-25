-- set diff hl
(function()
	for key, val in pairs(require("yasl.highlights").diff) do
		vim.api.nvim_set_hl(0, "Yasl" .. key, val)
	end
end)()

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

return {
	events = { "BufEnter", "BufWritePost" },
	update = function()
		if #vim.fn.expand("%") == 0 then return "" end -- no opened buffer

		local raw_diff = vim.fn.system(string.format("git --no-pager diff --no-color --no-ext-diff -U0 -- %s",
			vim.fn.expand("%")))

		if #raw_diff == 0 then return "" end -- no diff stats

		local added, removed, modified = "", "", ""
		local diff_stats = process_diff(split_lines(raw_diff))
		if diff_stats.added > 0 then
			added = string.format("%%#YaslAdded#+%s%%* ", diff_stats.added)
		end
		if diff_stats.removed > 0 then
			removed = string.format("%%#YaslRemoved#-%s%%* ", diff_stats.removed)
		end
		if diff_stats.modified > 0 then
			modified = string.format("%%#YaslModified#~%s%%*", diff_stats.modified)
		end

		return string.format("%s%s%s", added, removed, modified)
	end
}
