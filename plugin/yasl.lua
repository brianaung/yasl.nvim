local opts = vim.tbl_deep_extend("force", {
	components = {
		require("yasl.builtins.mode"),
		" ",
		"%<%t%h%m%r%w", -- filename
		require("yasl.builtins.gitbranch"),
		require("yasl.builtins.gitdiff"),
		require("yasl.builtins.diagnostic"),
		"%=",
		"[%-8.(%l, %c%V%) %P]", -- location, and progress
		" ",
	},
}, vim.g.yasl_opts or {})
vim.validate("components", opts.components, "table")

function set_statusline(items)
	local filtered = {}
	for _, str in ipairs(items) do
		if type(str) == "string" and str ~= "" then
			table.insert(filtered, str)
		end
	end
	vim.opt.statusline = table.concat(filtered):gsub("%s+", " ")
end

local status_strlist = {}
local group = vim.api.nvim_create_augroup("YaslSubscriptions", { clear = true })
for idx, component in ipairs(opts.components) do
	-- A component can be either a string, or a table that defines a 'update' function
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
					if status_strlist[idx] ~= new then
						status_strlist[idx] = new
						set_statusline(status_strlist)
					end
				end,
			})
		end

		table.insert(status_strlist, component.update() or "")
	elseif type(component) == "string" then
		table.insert(status_strlist, component)
	end
end
set_statusline(status_strlist)
