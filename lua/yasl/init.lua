_G.diagnostics = require("yasl.lib.diagnostics").diagnostics
_G.branch = require("yasl.lib.branch").branch

local M = {}

local get_status_grp = function(section, hl_name)
	if section.components == nil or #section.components == 0 then return "" end

	local components = {
		["mode"] = "%{mode()}",
		["filename"] = "%<%t%h%m%r%w",
		["branch"] = "%{luaeval('branch()')}",
		["diagnostics"] = "%{luaeval('diagnostics()')}",
		["filetype"] = "%y",
		["progress"] = "%P",
		["location"] = "%-8.(%l, %c%V%)",
	}

	-- set highlight (or its fallback)
	vim.api.nvim_set_hl(0, hl_name,
		vim.F.if_nil(section.highlight, vim.api.nvim_get_hl(0, { name = "StatusLine" })))

	-- group components for current section
	-- very hacky way to not show bg with content is empty
	if #section.components == 1 and
			(section.components[1] == "diagnostics" or section.components[1] == "filetype") and
			#vim.fn.expand("%") == 0 then
		return ""
	end

	local curr = string.format("%s%s%s", "%#", hl_name, "#")
	for i = 1, #section.components do
		curr = string.format("%s %s", curr, components[section.components[i]])
	end
	return string.format("%s %s", curr, "%*")
end

local get_status_str = function(opts)
	local default_sections = {
		a = { components = { "mode" } },
		b = { components = { "diagnostics" } },
		c = { components = { "filename", "branch" } },
		d = { components = { "filetype" } },
		e = { components = { "location", "progress" } },
	}

	local sections = (opts and opts.sections) and opts.sections or default_sections

	return table.concat({
		get_status_grp(vim.F.if_nil(sections.a, {}), "a"),
		get_status_grp(vim.F.if_nil(sections.b, {}), "b"),
		"%=",
		get_status_grp(vim.F.if_nil(sections.c, {}), "c"),
		"%=",
		get_status_grp(vim.F.if_nil(sections.d, {}), "d"),
		get_status_grp(vim.F.if_nil(sections.e, {}), "e")
	})
end

M.setup = function(opts)
	vim.api.nvim_set_option("laststatus", 3)
	vim.api.nvim_set_option("statusline", get_status_str(opts))
	vim.api.nvim_create_autocmd(
		{ "WinEnter", "BufEnter", "SessionLoadPost", "FileChangedShellPost", "VimResized", "Filetype", "CursorMoved",
			"CursorMovedI", "ModeChanged"
		}, {
			callback = function()
				vim.api.nvim_set_option("statusline", get_status_str(opts))
			end
		})
end

return M
