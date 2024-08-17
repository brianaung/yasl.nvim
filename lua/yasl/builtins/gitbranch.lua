return {
	events = { "WinEnter", "BufEnter" },
	update = function()
		local obj = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }):wait()
		local branch = vim.fn.substitute(obj.stdout or "", "\n", "", "g")
		if branch ~= "" then
			return string.format(" [%s] ", branch)
		end
	end,
}
