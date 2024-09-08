local M = {}

M._status_strlist = {}

M.opts = {
	components = {
		require("yasl.builtins.mode"),
		"%#StatusLineNC# %<%t%h%m%r%w %*", -- filename
		"%=",
		"%#StatusLineNC# [%-8.(%l, %c%V%) %P] %*", -- location, and progress
	},
}

M.setup = function(opts)
	M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
	vim.validate {
		["components"] = { M.opts.components, "t" },
	}

	local group = vim.api.nvim_create_augroup("YaslSubscriptions", { clear = true })

	-- A component can be either a string, or a table that defines a 'update' function
	for idx, component in ipairs(M.opts.components) do
		if type(component) == "table" then
			if type(component.update) ~= "function" then
				vim.notify("yasl.nvim: component table should contain update function.", vim.log.levels.ERROR)
				return
			end

			-- Setup refresh events
			local events = component.events or {}
			if next(events) then
				vim.api.nvim_create_autocmd(events, {
					group = group,
					callback = function()
						local new = component.update() or ""
						if M._status_strlist[idx] ~= new then
							M._status_strlist[idx] = new
							M._set_statusline(M._status_strlist)
						end
					end,
				})
			end

			table.insert(M._status_strlist, component.update() or "")
		elseif type(component) == "string" then
			table.insert(M._status_strlist, component)
		end
	end

	M._set_statusline(M._status_strlist)
end

M._set_statusline = function(status_strlist)
	local filtered = {}
	for _, str in ipairs(status_strlist) do
		if type(str) == "string" and str ~= "" then
			table.insert(filtered, str)
		end
	end
	vim.opt.statusline = table.concat(filtered):gsub("%s+", " ")
end

return M
