local M = {}

M._status_strings = {}

M.opts = {
	separator = " ",
	components = {
		require("yasl.builtins.mode"),
		"%<%t%h%m%r%w", -- filename
		require("yasl.builtins.gitbranch"),
		require("yasl.builtins.diagnostic"),
		require("yasl.builtins.gitdiff"),
		"%=",
		"[%-8.(%l, %c%V%) %P]", -- location, and progress
	},
}

M.setup = function(opts)
	M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
	vim.validate {
		["components"] = { M.opts.components, "t" },
	}

	local group = vim.api.nvim_create_augroup("YaslSubscriptions", { clear = true })

	for idx, component in ipairs(M.opts.components) do
		if type(component) == "table" then
			if type(component.update) ~= "function" then
				vim.notify("yasl.nvim: component table should contain update function.", vim.log.levels.ERROR)
				return
			end

			local events = component.events or {}
			if next(events) then
				vim.api.nvim_create_autocmd(events, {
					group = group,
					callback = function()
						local new = component.update() or ""
						if M._status_strings[idx] ~= new then
							M._status_strings[idx] = new
							vim.opt.statusline = table.concat(M._status_strings, M.opts.separator)
						end
					end,
				})
			end

			table.insert(M._status_strings, component.update() or "")
		elseif type(component) == "string" then
			table.insert(M._status_strings, component)
		end
	end

	vim.opt.statusline = table.concat(M._status_strings, M.opts.separator)
end

return M
