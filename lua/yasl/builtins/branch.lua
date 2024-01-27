return {
	name = "branch",
	events = { "WinEnter", "BufEnter" },
	update = function()
		local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
		if branch ~= "" then
			if _YaslConfig.global_settings.enable_icons then
				return string.format("%s", branch)
			else
				return string.format("[%s]", branch)
			end
		else
			return ""
		end
	end
}
