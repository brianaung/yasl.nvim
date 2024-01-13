-- local diagnostics = require("yasl.component").diagnostics
local diagnostics = require("yasl.component").diagnostics
local branch = require("yasl.component").branch

-- some component can have empty content, in which case we don't want to show the bg
local is_component_empty = function(component)
	if component == "filetype" and #vim.fn.expand("%") == 0 then
		return true
	end
	if component == "diagnostics" and diagnostics() == "" then
		return true
	end
	return false
end

local fallback_color = vim.api.nvim_get_hl(0, { name = "StatusLine" })

local get_status_grp = function(section, hl_name)
	if section.components == nil or
			#section.components == 0 or
			(#section.components == 1 and is_component_empty(section.components[1])) then
		return ""
	end

	local components = {
		["mode"] = "%{mode()}",
		["filename"] = "%<%t%h%m%r%w",
		["branch"] = branch(),
		-- ["diagnostics"] = "%{luaeval('diagnostics()')}",
		["diagnostics"] = diagnostics(),
		["filetype"] = "%y",
		["progress"] = "%P",
		["location"] = "%-8.(%l, %c%V%)",
	}

	-- set highlight (or its fallback)
	vim.api.nvim_set_hl(0, hl_name,
		vim.F.if_nil(section.highlight, fallback_color))

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

local default_refresh_events = {
	"LspAttach", "WinEnter", "BufEnter", "SessionLoadPost",
	"FileChangedShellPost", "VimResized", "Filetype", "CursorMoved",
	"CursorMovedI", "ModeChanged"
}

local M = {}

M.setup = function(opts)
	vim.api.nvim_set_option("laststatus", 3)
	vim.api.nvim_set_option("statusline", get_status_str(opts))
	vim.api.nvim_create_autocmd(default_refresh_events, {
		callback = function()
			vim.api.nvim_set_option("statusline", get_status_str(opts))
		end
	})
end

return M
