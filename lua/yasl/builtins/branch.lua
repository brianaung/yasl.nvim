return {
	events = { "BufEnter" },
	update = function()
		local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
		if branch ~= "" then
			return string.format("[%s]", branch)
		else
			return ""
		end
	end
}
